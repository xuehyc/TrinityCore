/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _PROCESSPRIO_H
#define _PROCESSPRIO_H

#include "Define.h"
#include <string>

#define CONFIG_PROCESSOR_AFFINITY "UseProcessors"
#define CONFIG_HIGH_PRIORITY "ProcessPriority"

void COMMON_API SetProcessPriority(std::string const& logChannel, uint32 affinity, bool highPriority);

#endif
