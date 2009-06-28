FIND_PATH(VORBIS_INCLUDE_DIR vorbis/vorbisfile.h)
FIND_PATH(OGG_INCLUDE_DIR ogg/ogg.h)

FIND_LIBRARY(OGG_LIBRARY NAMES ogg)

FIND_LIBRARY(VORBIS_LIBRARY NAMES vorbis)
FIND_LIBRARY(VORBISFILE_LIBRARY NAMES vorbisfile)

IF(VORBIS_INCLUDE_DIR AND OGG_LIBRARY AND VORBIS_LIBRARY AND VORBISFILE_LIBRARY)
    SET(OGGVORBIS_FOUND TRUE)
    SET(OGGVORBIS_LIBRARIES ${OGG_LIBRARY} ${VORBIS_LIBRARY} ${VORBISFILE_LIBRARY})
    SET(OGGVORBIS_INCLUDE_DIRS ${VORBIS_INCLUDE_DIR} ${OGG_INCLUDE_DIR})
ELSE(VORBIS_INCLUDE_DIR AND OGG_LIBRARY AND VORBIS_LIBRARY AND VORBISFILE_LIBRARY)
    SET(OGGVORBIS_FOUND FALSE)
ENDIF(VORBIS_INCLUDE_DIR AND OGG_LIBRARY AND VORBIS_LIBRARY AND VORBISFILE_LIBRARY)

IF(OGGVORBIS_FOUND)
    MESSAGE(STATUS "Found OggVorbis: ${OGGVORBIS_LIBRARIES}")
ELSE(OGGVORBIS_FOUND)
    MESSAGE(FATAL_ERROR "Could NOT find Ogg and/or Vorbis - Visit xiph.org for them")
ENDIF(OGGVORBIS_FOUND)


