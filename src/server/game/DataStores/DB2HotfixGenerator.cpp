/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "DB2HotfixGenerator.h"
#include "DB2Stores.h"
#include "Log.h"

void DB2HotfixGeneratorBase::LogMissingRecord(std::string const& storageName, uint32 recordId)
{
    LOG_ERROR("db2.hotfix", "Hotfix specified for %s row id %u which does not exist", storageName.c_str(), recordId);
}

void DB2HotfixGeneratorBase::AddClientHotfix(uint32 tableHash, uint32 recordId)
{
    sDB2Manager.InsertNewHotfix(tableHash, recordId);
}
