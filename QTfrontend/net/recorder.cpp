/*
 * Hedgewars, a free turn based strategy game
 * Copyright (c) 2004-2012 Andrey Korotaev <unC0Rr@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 */

#include <QString>
#include <QByteArray>

#include "recorder.h"
#include "gameuiconfig.h"
#include "hwconsts.h"
#include "game.h"
#include "LibavInteraction.h"

// Encoding is memory expensive process, so we need to limit maximum number
// of simultaneous encoders.
static const int maxRecorders = 3;
static int numRecorders = 0;

static QList<HWRecorder*> queue;

HWRecorder::HWRecorder(GameUIConfig * config, const QString &prefix) :
    TCPBase(false)
{
    this->config = config;
    this->prefix = prefix;
    finished = false;
    name = prefix + "." + LibavInteraction::instance().getExtension(config->AVFormat());
}

HWRecorder::~HWRecorder()
{
    emit encodingFinished(finished);
    if (queue.empty())
        numRecorders--;
    else
        queue.takeFirst()->Start(false);
}

void HWRecorder::onClientDisconnect()
{
}

void HWRecorder::onClientRead()
{
    quint8 msglen;
    quint32 bufsize;
    while (!readbuffer.isEmpty() && ((bufsize = readbuffer.size()) > 0) &&
            ((msglen = readbuffer.data()[0]) < bufsize))
    {
        QByteArray msg = readbuffer.left(msglen + 1);
        readbuffer.remove(0, msglen + 1);
        switch (msg.at(1))
        {
        case '?':
            SendIPC("!");
            break;
        case 'p':
            emit onProgress((quint8(msg.at(2))*256.0 + quint8(msg.at(3)))*0.0001);
            break;
        case 'v':
            finished = true;
            break;
        }
    }
}

void HWRecorder::EncodeVideo(const QByteArray & record)
{
    toSendBuf = record;
    toSendBuf.replace(QByteArray("\x02TD"), QByteArray("\x02TV"));
    toSendBuf.replace(QByteArray("\x02TL"), QByteArray("\x02TV"));
    toSendBuf.replace(QByteArray("\x02TN"), QByteArray("\x02TV"));
    toSendBuf.replace(QByteArray("\x02TS"), QByteArray("\x02TV"));

    if (numRecorders < maxRecorders)
    {
        numRecorders++;
        Start(false); // run engine
    }
    else
        queue.push_back(this);
}

QStringList HWRecorder::getArguments()
{
    QStringList arguments;
    QRect resolution = config->rec_Resolution();
    arguments << cfgdir->absolutePath();
    arguments << QString::number(resolution.width());
    arguments << QString::number(resolution.height());
    arguments << "32"; // bpp
    arguments << QString("%1").arg(ipc_port);
    arguments << "0"; // fullscreen
    arguments << "0"; // sound
    arguments << "0"; // music
    arguments << "0"; // sound volume
    arguments << QString::number(config->timerInterval());
    arguments << datadir->absolutePath();
    arguments << "0"; // fps
    arguments << (config->isAltDamageEnabled() ? "1" : "0");
    arguments << config->netNick().toUtf8().toBase64();
    arguments << QString::number(config->translateQuality());
    arguments << QString::number(config->stereoMode());
    arguments << HWGame::tr("en.txt");
    arguments << QString::number(config->rec_Framerate()); // framerate numerator
    arguments << "1";  // framerate denominator
    arguments << prefix;
    arguments << config->AVFormat();
    arguments << config->videoCodec();
// Could use a field to use quality instead. maybe quality could override bitrate - or just pass (and set) both. 
// The library does support using both at once after all.
    arguments << QString::number(config->rec_Bitrate()*1024);
    arguments << (config->recordAudio() ? config->audioCodec() : "no");

    return arguments;
}