/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "DatabaseEnv.h"

DatabaseWorkerPool<WorldDatabaseConnection> WorldDatabase;
DatabaseWorkerPool<CharacterDatabaseConnection> CharacterDatabase;
DatabaseWorkerPool<LoginDatabaseConnection> LoginDatabase;
DatabaseWorkerPool<HotfixDatabaseConnection> HotfixDatabase;
