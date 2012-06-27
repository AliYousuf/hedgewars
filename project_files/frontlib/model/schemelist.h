/*
 * Hedgewars, a free turn based strategy game
 * Copyright (C) 2012 Simeon Maxein <smaxein@googlemail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

/**
 * Functions for managing a list of schemes.
 * This is in here because the scheme config file of the QtFrontend (which we are staying compatble with) contains
 * all the schemes at once, so we need functions to work with a list like that.
 */

#ifndef SCHEMELIST_H_
#define SCHEMELIST_H_

#include "cfg.h"

typedef struct {
	int _referenceCount;
	int schemeCount;
	flib_cfg **schemes;
} flib_schemelist;

/**
 * Load a list of configurations from the ini file.
 * Returns NULL on error.
 */
flib_schemelist *flib_schemelist_from_ini(flib_cfg_meta *meta, const char *filename);

/**
 * Store the list of configurations to an ini file.
 * Returns NULL on error.
 */
int flib_schemelist_to_ini(const char *filename, const flib_schemelist *config);

/**
 * Create an empty scheme list. Returns NULL on error.
 */
flib_schemelist *flib_schemelist_create();

/**
 * Insert a new scheme into the list at position pos, moving all higher schemes to make place.
 * pos must be at least 0 (insert at the start) and at most list->schemeCount (insert at the end).
 * The scheme is retained automatically.
 * Returns 0 on success.
 */
int flib_schemelist_insert(flib_schemelist *list, flib_cfg *cfg, int pos);

/**
 * Delete a cfg from the list at position pos, moving down all higher schemes.
 * The scheme is released automatically.
 * Returns 0 on success.
 */
int flib_schemelist_delete(flib_schemelist *list, int pos);

/**
 * Find the scheme with a specific name
 */
flib_cfg *flib_schemelist_find(flib_schemelist *list, const char *name);

/**
 * Increase the reference count of the object. Call this if you store a pointer to it somewhere.
 * Returns the parameter.
 */
flib_schemelist *flib_schemelist_retain(flib_schemelist *list);

/**
 * Decrease the reference count of the object and free it if this was the last reference.
 */
void flib_schemelist_release(flib_schemelist *list);


#endif /* SCHEMELIST_H_ */
