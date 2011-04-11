#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

#define N_LAKKA                     18956
#define Q_BRUDER                    10097
#define SAY_DANKE                   "Danke, dass ihr mich gerettet habt"

class npc_lakka : public CreatureScript
{
public:
    npc_lakka() : CreatureScript("npc_lakka") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        npc_lakkaAI* lakkaAI = new npc_lakkaAI(_Creature);

        lakkaAI->AddWaypoint(0, -157.42f, 179.51f, 0.0f);
        lakkaAI->AddWaypoint(1, -140.22f, 183.01f, 0.0f);
        lakkaAI->AddWaypoint(2, -131.91f, 175.58f, 0.0f);
        lakkaAI->AddWaypoint(3, -78.13f, 172.95f, 0.0f);
        lakkaAI->AddWaypoint(4, -73.97f, 156.24f, 0.0f);

        return lakkaAI;
    }

    struct  npc_lakkaAI : public npc_escortAI
    {

        npc_lakkaAI(Creature *c) : npc_escortAI(c) {}
    
        void WaypointReached(uint32 i)
        {
            Unit* player = Unit::GetUnit((*me), GetEventStarterGUID());
        
            if (!player)
                return;

            switch(i) 
            {
            case 1:
                me->MonsterSay(SAY_DANKE, LANG_UNIVERSAL, NULL);
                Map *map = me->GetMap();
                if(map->IsDungeon())
                {
                    InstanceMap::PlayerList const &PlayerList = ((InstanceMap*)map)->GetPlayers();
                    for (InstanceMap::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (Player* i_pl = i->getSource())
                        {
                            if(i_pl->GetQuestStatus(10097) == QUEST_STATUS_INCOMPLETE)
                                i_pl->KilledMonsterCredit(N_LAKKA,me->GetGUID());
                        }
                    }
                }
                break;
            }
        }

        void EnterCombat(Unit* who){}

        void Reset()
        {
        }

        void UpdateAI(const uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);
        }

    };
};

class go_lakka : public GameObjectScript
{
public:
    go_lakka() : GameObjectScript("go_lakka") { }

    bool OnGossipHello (Player *player, GameObject* _GO)
    {
        if(Creature* Lakka = GetClosestCreatureWithEntry(player,N_LAKKA,35))
        {
            CAST_AI(npc_escortAI,Lakka->AI())->Start(false,true, player->GetGUID());
            //Map *map = Lakka->GetMap();
            //if(map->IsDungeon())
            //{
            //    InstanceMap::PlayerList const &PlayerList = ((InstanceMap*)map)->GetPlayers();
            //    for (InstanceMap::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            //    {
            //        if (Player* i_pl = i->getSource())
            //        {
            //            if(i_pl->GetQuestStatus(10097) == QUEST_STATUS_INCOMPLETE)
            //                i_pl->KilledMonsterCredit(N_LAKKA,Lakka->GetGUID());
            //                _GO->DestroyForPlayer(i_pl);
            //        }
            //    }
            // }
        }
        return false;
    }
};

void AddSC_sethekk_halls()
{
    new npc_lakka();
    new go_lakka();
}