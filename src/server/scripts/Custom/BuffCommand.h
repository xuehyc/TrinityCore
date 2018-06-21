#ifndef KARGATUM_BUFFCOMMAND_H
#define KARGATUM_BUFFCOMMAND_H

#include "ScriptPCH.h"
#include "AccountMgr.h"

class Kargatum_Buff
{
public:
	void LoadDB();

	typedef std::vector<uint32> Kargatum_Buff_Container;
	Kargatum_Buff_Container &GetBuffData() { return _buffStore; }

private:
	Kargatum_Buff_Container _buffStore;
};

#define sKargatumBuff ACE_Singleton<Kargatum_Buff, ACE_Null_Mutex>::instance()

#endif
