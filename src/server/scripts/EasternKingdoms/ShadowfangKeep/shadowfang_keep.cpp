 /*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Shadowfang_Keep
SD%Complete: 75
SDComment: npc_shadowfang_prisoner using escortAI for movement to door. Might need additional code in case being attacked. Add proper texts/say().
SDCategory: Shadowfang Keep
EndScriptData */

/* ContentData
npc_shadowfang_prisoner
EndContentData */

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"
#include "shadowfang_keep.h"

/*######
## npc_shadowfang_prisoner
######*/

enum eEnums
{
    SAY_FREE_AS             = -1033000,
    SAY_OPEN_DOOR_AS        = -1033001,
    SAY_POST_DOOR_AS        = -1033002,
    SAY_FREE_AD             = -1033003,
    SAY_OPEN_DOOR_AD        = -1033004,
    SAY_POST1_DOOR_AD       = -1033005,
    SAY_POST2_DOOR_AD       = -1033006,

    SPELL_UNLOCK            = 6421,
    NPC_ASH                 = 3850,

    SPELL_DARK_OFFERING     = 7154
};

#define GOSSIP_ITEM_DOOR        "Thanks, I'll follow you to the door."

class npc_shadowfang_prisoner : public CreatureScript
{
public:
    npc_shadowfang_prisoner() : CreatureScript("npc_shadowfang_prisoner") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_shadowfang_prisonerAI(pCreature);
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            pPlayer->CLOSE_GOSSIP_MENU();

            if (npc_escortAI* pEscortAI = CAST_AI(npc_shadowfang_prisoner::npc_shadowfang_prisonerAI, pCreature->AI()))
                pEscortAI->Start(false, false);
        }
        return true;
    }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        InstanceScript* pInstance = pCreature->GetInstanceScript();

        if (pInstance && pInstance->GetData(TYPE_FREE_NPC) != DONE && pInstance->GetData(TYPE_RETHILGORE) == DONE)
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_DOOR, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());

        return true;
    }

    struct npc_shadowfang_prisonerAI : public npc_escortAI
    {
        npc_shadowfang_prisonerAI(Creature *c) : npc_escortAI(c)
        {
            pInstance = c->GetInstanceScript();
            uiNpcEntry = c->GetEntry();
        }

        InstanceScript *pInstance;
        uint32 uiNpcEntry;

        void WaypointReached(uint32 uiPoint)
        {
            switch(uiPoint)
            {
                case 0:
                    if (uiNpcEntry == NPC_ASH)
                        DoScriptText(SAY_FREE_AS, me);
                    else
                        DoScriptText(SAY_FREE_AD, me);
                    break;
                case 10:
                    if (uiNpcEntry == NPC_ASH)
                        DoScriptText(SAY_OPEN_DOOR_AS, me);
                    else
                        DoScriptText(SAY_OPEN_DOOR_AD, me);
                    break;
                case 11:
                    if (uiNpcEntry == NPC_ASH)
                        DoCast(me, SPELL_UNLOCK);
                    break;
                case 12:
                    if (uiNpcEntry == NPC_ASH)
                        DoScriptText(SAY_POST_DOOR_AS, me);
                    else
                        DoScriptText(SAY_POST1_DOOR_AD, me);

                    if (pInstance)
                        pInstance->SetData(TYPE_FREE_NPC, DONE);
                    break;
                case 13:
                    if (uiNpcEntry != NPC_ASH)
                        DoScriptText(SAY_POST2_DOOR_AD, me);
                    break;
            }
        }

        void Reset() {}
        void EnterCombat(Unit* /*who*/) {}
    };

};

class npc_arugal_voidwalker : public CreatureScript
{
public:
    npc_arugal_voidwalker() : CreatureScript("npc_arugal_voidwalker") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_arugal_voidwalkerAI(pCreature);
    }

    struct npc_arugal_voidwalkerAI : public ScriptedAI
    {
        npc_arugal_voidwalkerAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 uiDarkOffering;

        void Reset()
        {
            uiDarkOffering = urand(290,10);
        }

        void UpdateAI(uint32 const uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (uiDarkOffering <= uiDiff)
            {
                if (Creature* pFriend = me->FindNearestCreature(me->GetEntry(),25.0f,true))
                {
                    if (pFriend)
                        DoCast(pFriend,SPELL_DARK_OFFERING);
                }
                else
                    DoCast(me,SPELL_DARK_OFFERING);
                uiDarkOffering = urand(4400,12500);
            } else uiDarkOffering -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*pKiller*/)
        {
            if (pInstance)
                pInstance->SetData(TYPE_FENRUS, pInstance->GetData(TYPE_FENRUS) + 1);
        }
    };

};

/*######
## apothecary hummel
######*/

enum eHummel
{
    FACTION_HOSTIL                   = 14,
    QUEST_YOUVE_BEEN_SERVED          = 14488,
    NPC_CRAZED_APOTHECARY            = 36568,
    NPC_VIAL_BUNNY                   = 36530,

    SAY_AGGRO_1                      = -1033020,
    SAY_AGGRO_2                      = -1033021,
    SAY_AGGRO_3                      = -1033022,
    SAY_CALL_BAXTER                  = -1033023,
    SAY_CALL_FRYE                    = -1033024,
    SAY_SUMMON_ADDS                  = -1033025,
    SAY_DEATH                        = -1033026,

    SPELL_ALLURING_PERFUME           = 68589,
    SPELL_ALLURING_PERFUME_SPRAY     = 68607,
    SPELL_IRRESISTIBLE_COLOGNE       = 68946,
    SPELL_IRRESISTIBLE_COLOGNE_SPRAY = 68948,

    SPELL_TABLE_APPEAR               = 69216,
    SPELL_SUMMON_TABLE               = 69218,
    SPELL_CHAIN_REACTION             = 68821,
    SPELL_UNSTABLE_REACTION          = 68957,

    // frye
    SPELL_THROW_PERFUME              = 68799,
    SPELL_THROW_COLOGNE              = 68841,
    SPELL_ALLURING_PERFUME_SPILL     = 68798,
    SPELL_IRRESISTIBLE_COLOGNE_SPILL = 68614,
};

enum eAction
{
    START_INTRO,
    START_FIGHT,
    APOTHECARY_DIED,
    SPAWN_CRAZED
};

enum ePhase
{
    PHASE_NORMAL,
    PHASE_INTRO
};

static Position Loc[]=
{
    // spawn points
    {-215.776443f, 2242.365479f, 79.769257f, 0.0f},
    {-169.500702f, 2219.286377f, 80.613045f, 0.0f},
    {-200.056641f, 2152.635010f, 79.763107f, 0.0f},
    {-238.448242f, 2165.165283f, 89.582985f, 0.0f},
    // moveto points
    {-210.784164f, 2219.004150f, 79.761803f, 0.0f},
    {-198.453400f, 2208.410889f, 79.762474f, 0.0f},
    {-208.469910f, 2167.971924f, 79.764969f, 0.0f},
    {-228.251511f, 2187.282471f, 79.762840f, 0.0f}
};

class npc_apothecary_hummel : public CreatureScript
{
public:
    npc_apothecary_hummel() : CreatureScript("npc_apothecary_hummel") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_apothecary_hummelAI(pCreature);
    }

    struct npc_apothecary_hummelAI : public ScriptedAI
    {
        npc_apothecary_hummelAI(Creature *c) : ScriptedAI(c), lSummons(me) 
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        SummonList lSummons;
        
        uint8 uiDeadCount;
        uint8 uiPhase;
        uint8 uiStep;
        uint32 uiPingTimer;
        uint32 uiStepTimer;
        uint32 uiSprayTimer;
        uint32 uiChainReactionTimer;

        bool bFirstCrazed;

        void Reset()
        {
            me->RestoreFaction();
            uiPhase = PHASE_NORMAL;

            uiStep = 0;
            uiDeadCount = 0;
            uiStepTimer = 1500;
            uiPingTimer = 5000;
            uiSprayTimer = urand(4000, 7000);
            uiChainReactionTimer = urand(10000, 25000);

            bFirstCrazed = false;

            me->SetCorpseDelay(900); // prevent fast despawn while still fighting baxter or frye
            lSummons.DespawnAll(); // clear crazed apothecarys spawned

            if (!pInstance)
                return;

            pInstance->SetData(TYPE_CROWN, NOT_STARTED);

            if (Creature* pBaxter = Unit::GetCreature(*me, pInstance->GetData64(DATA_BAXTER)))
                if (pBaxter->isAlive())
                {
                    pBaxter->AI()->EnterEvadeMode();
                } else
                    pBaxter->Respawn();

            if (Creature* pFrye = Unit::GetCreature(*me, pInstance->GetData64(DATA_FRYE)))
                if (pFrye->isAlive())
                {
                    pFrye->AI()->EnterEvadeMode();
                } else
                    pFrye->Respawn();

            // open door by default as long as the event is active
            if (GameObject *Door = pInstance->instance->GetGameObject(pInstance->GetData64(DATA_DOOR)))
                pInstance->HandleGameObject(NULL, true, Door);
        }

        void DoAction(const int32 actionId)
        {
            if (!pInstance)
                return;

            switch (actionId)
            {
                case START_INTRO:
                {
                    if (Creature* pBaxter = Unit::GetCreature(*me, pInstance->GetData64(DATA_BAXTER)))
                        pBaxter->AI()->DoAction(START_INTRO);
                    if (Creature* pFrye = Unit::GetCreature(*me, pInstance->GetData64(DATA_FRYE)))
                        pFrye->AI()->DoAction(START_INTRO);

                    uiPhase = PHASE_INTRO;
                    me->SetReactState(REACT_PASSIVE);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    SetInCombat();
                    break;
                }
                case START_FIGHT:
                {
                    uiPhase = PHASE_NORMAL;
                    me->setFaction(FACTION_HOSTIL);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    SetInCombat();
                    pInstance->SetData(TYPE_CROWN, IN_PROGRESS);
                    break;
                }
                case APOTHECARY_DIED:
                {
                    ++uiDeadCount;
                    if (uiDeadCount > 2) // all 3 apothecarys dead, set lootable
                    {
                        lSummons.DespawnAll();
                        me->SetCorpseDelay(90); // shorten delay
                        me->setDeathState(JUST_DIED); // update delay
                        pInstance->SetData(TYPE_CROWN, DONE);
                        me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                    }
                    else
                    {
                        if (me->HasFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE))
                            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                    }
                    break;
                }
                case SPAWN_CRAZED:
                {
                    uint8 i = urand(0,3);
                    if (Creature *pCrazed = me->SummonCreature(NPC_CRAZED_APOTHECARY, Loc[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3*IN_MILLISECONDS))
                    {
                        pCrazed->setFaction(FACTION_HOSTIL);
                        pCrazed->SetReactState(REACT_PASSIVE);
                        pCrazed->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        pCrazed->GetMotionMaster()->MovePoint(1, Loc[i+4]);
                    }
                    if (!bFirstCrazed)
                    {
                        DoScriptText(SAY_SUMMON_ADDS, me);
                        bFirstCrazed = true;
                    }

                    break;
                }
            }
        }

        void SetInCombat()
        {
            Map *map = me->GetMap();
            if (!map->IsDungeon())
                return;

            bool found = false;

            Map::PlayerList const &PlayerList = map->GetPlayers();
            for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Player* i_pl = i->getSource())
                    if (!i_pl->isGameMaster() && i_pl->isAlive() && me->GetDistance(i_pl) <= 100)
                    {
                        me->SetInCombatWith(i_pl);
                        i_pl->SetInCombatWith(me);
                        me->AddThreat(i_pl, 1.0f);
                        found = true;
                    }
            }          
            if (!found)
                EnterEvadeMode();
        }

        void UpdateAI(const uint32 diff)
        {
            if (uiPhase == PHASE_INTRO)
            {
                // just some talk
                if (uiStepTimer <= diff)
                {
                    ++uiStep;
                    switch (uiStep)
                    {
                        case 1:
                        {
                            DoScriptText(SAY_AGGRO_1, me);
                            uiStepTimer = 4000;
                            break;
                        }
                        case 2:
                        {
                            DoScriptText(SAY_AGGRO_2, me);
                            uiStepTimer = 5500;
                            break;
                        }
                        case 3:
                        {
                            DoScriptText(SAY_AGGRO_3, me);
                            uiStepTimer = 1000;
                            break;
                        }
                        case 4:
                        {
                            DoAction(START_FIGHT);
                            break;
                        }
                    }
                } else uiStepTimer -= diff;
            }
            else // PHASE_NORMAL
            {
                if (!UpdateVictim())
                    return;

                if (uiPingTimer <= diff)
                {
                    SetInCombat();
                    uiPingTimer = 5000;
                } else uiPingTimer -= diff;

                if (me->HasUnitState(UNIT_STAT_CASTING))
                    return;

                if (uiChainReactionTimer <= diff)
                {
                    DoCast(me, SPELL_TABLE_APPEAR, true);
                    DoCast(me, SPELL_SUMMON_TABLE, true);
                    DoCast(SPELL_CHAIN_REACTION);
                    uiChainReactionTimer = urand(15000, 25000);
                } else uiChainReactionTimer -= diff;

                if (uiSprayTimer <= diff)
                {
                    DoCast(me->getVictim(), SPELL_ALLURING_PERFUME_SPRAY, false);
                    uiSprayTimer = urand(8000, 15000);
                } else uiSprayTimer -= diff;

                DoMeleeAttackIfReady();
            }
        }

        void JustSummoned(Creature *summon)
        {
            lSummons.Summon(summon);
        }

        void JustDied(Unit* /*killer*/)
        {
            DoAction(APOTHECARY_DIED);
            DoScriptText(SAY_DEATH, me);
        }
    };

    bool OnQuestReward(Player* pPlayer, Creature* pCreature, const Quest *_quest, uint32 /*item*/)
    {
        if (_quest->GetQuestId() == QUEST_YOUVE_BEEN_SERVED)
        {
            CAST_AI(npc_apothecary_hummel::npc_apothecary_hummelAI, pCreature->AI())->DoAction(START_INTRO);
        }
        return true;
    }
};

/*######
## apothecary baxter
######*/

class npc_apothecary_baxter : public CreatureScript
{
public:
    npc_apothecary_baxter() : CreatureScript("npc_apothecary_baxter") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_apothecary_baxterAI(pCreature);
    }

    struct npc_apothecary_baxterAI : public ScriptedAI
    {
        npc_apothecary_baxterAI(Creature *c) : ScriptedAI(c) 
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 uiChainReactionTimer;
        uint32 uiSprayTimer;
        uint32 uiPingTimer;
        uint32 uiWaitTimer;
        uint8 uiPhase;

        void Reset()
        {
            me->RestoreFaction();

            uiPingTimer = 5000;
            uiWaitTimer = 20000;
            uiSprayTimer = urand(4000, 7000);
            uiChainReactionTimer = urand (10000, 25000);
            uiPhase = PHASE_NORMAL;

            if (!pInstance)
                return;

            if (Creature* pHummel = Unit::GetCreature(*me, pInstance->GetData64(DATA_HUMMEL)))
                if (pHummel->isAlive())
                {
                    pHummel->AI()->EnterEvadeMode();
                } else
                    pHummel->Respawn();
        }

        void SetInCombat()
        {
            Map *map = me->GetMap();
            if (!map->IsDungeon())
                return;

            bool found = false;

            Map::PlayerList const &PlayerList = map->GetPlayers();
            for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Player* i_pl = i->getSource())
                    if (!i_pl->isGameMaster() && i_pl->isAlive() && me->GetDistance(i_pl) <= 100)
                    {
                        me->SetInCombatWith(i_pl);
                        i_pl->SetInCombatWith(me);
                        me->AddThreat(i_pl, 1.0f);
                        found = true;
                    }
            }          
            if (!found)
                EnterEvadeMode();
        }

        void DoAction(const int32 actionId)
        {
            if (!pInstance)
                return;

            switch (actionId)
            {
                case START_INTRO:
                {
                    uiPhase = PHASE_INTRO;
                    break;
                }
                case START_FIGHT:
                {
                    if (Creature* pHummel = Unit::GetCreature(*me, pInstance->GetData64(DATA_HUMMEL)))
                        DoScriptText(SAY_CALL_BAXTER, pHummel);
                    uiPhase = PHASE_NORMAL;
                    me->setFaction(FACTION_HOSTIL);
                    SetInCombat();
                    break;
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (uiPhase == PHASE_INTRO)
            {
                if (uiWaitTimer <= diff)
                {
                    DoAction(START_FIGHT);
                } else uiWaitTimer -= diff;
            }
            else // PHASE_NORMAL
            {
                if (!UpdateVictim())
                    return;

                if (uiPingTimer <= diff)
                {
                    SetInCombat();
                    uiPingTimer = 5000;
                } else uiPingTimer -= diff;

                if (me->HasUnitState(UNIT_STAT_CASTING))
                    return;

                if (uiChainReactionTimer <= diff)
                {
                    DoCast(me, SPELL_TABLE_APPEAR, true);
                    DoCast(me, SPELL_SUMMON_TABLE, true);
                    DoCast(SPELL_CHAIN_REACTION);
                    uiChainReactionTimer = urand(15000, 25000);
                } else uiChainReactionTimer -= diff;

                if (uiSprayTimer <= diff)
                {
                    DoCast(me->getVictim(), SPELL_IRRESISTIBLE_COLOGNE_SPRAY, false);
                    uiSprayTimer = urand(8000, 15000);
                } else uiSprayTimer -= diff;

                DoMeleeAttackIfReady();
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (!pInstance)
                return;

            if (Creature* pHummel = Unit::GetCreature(*me, pInstance->GetData64(DATA_HUMMEL)))
                pHummel->AI()->DoAction(APOTHECARY_DIED);
        }
    };
};

/*######
## apothecary frye
######*/

class npc_apothecary_frye : public CreatureScript
{
public:
    npc_apothecary_frye() : CreatureScript("npc_apothecary_frye") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_apothecary_fryeAI(pCreature);
    }

    struct npc_apothecary_fryeAI : public ScriptedAI
    {
        npc_apothecary_fryeAI(Creature *c) : ScriptedAI(c) 
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 uiThreatTimer;
        uint32 uiThrowTimer;
        uint32 uiPingTimer;        
        uint32 uiWaitTimer;
        uint8 uiPhase;

        void Reset()
        {
            me->RestoreFaction();

            uiPingTimer = 5000;
            uiWaitTimer = 28000;
            uiThrowTimer = urand(2000, 4000);
            uiThreatTimer = urand(1000, 2000);
            uiPhase = PHASE_NORMAL;

            if (!pInstance)
                return;

            if (Creature* pHummel = Unit::GetCreature(*me, pInstance->GetData64(DATA_HUMMEL)))
                if (pHummel->isAlive())
                {
                    pHummel->AI()->EnterEvadeMode();
                } else
                    pHummel->Respawn();
        }

        void SetInCombat()
        {
            Map *map = me->GetMap();
            if (!map->IsDungeon())
                return;

            bool found = false;

            Map::PlayerList const &PlayerList = map->GetPlayers();
            for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Player* i_pl = i->getSource())
                    if (!i_pl->isGameMaster() && i_pl->isAlive() && me->GetDistance(i_pl) <= 100)
                    {
                        me->SetInCombatWith(i_pl);
                        i_pl->SetInCombatWith(me);
                        me->AddThreat(i_pl, 1.0f);
                        found = true;
                    }
            }          
            if (!found)
                EnterEvadeMode();
        }

        void DoAction(const int32 actionId)
        {
            if (!pInstance)
                return;

            switch (actionId)
            {
                case START_INTRO:
                {
                    uiPhase = PHASE_INTRO;
                    break;
                }
                case START_FIGHT:
                {
                    if (Creature* pHummel = Unit::GetCreature(*me, pInstance->GetData64(DATA_HUMMEL)))
                        DoScriptText(SAY_CALL_FRYE, pHummel);
                    uiPhase = PHASE_NORMAL;
                    me->setFaction(FACTION_HOSTIL);
                    SetInCombat();
                    break;
                }
            }
        }

        void SummonBunny(Unit *pUnit, bool bPerfume)
        {
            if (!pUnit)
                return;

            float x,y,z;
            pUnit->GetPosition(x,y,z);

            if (Creature *pBunny = me->SummonCreature(NPC_VIAL_BUNNY, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 25*IN_MILLISECONDS))
            {
                pBunny->setFaction(FACTION_HOSTIL);
                pBunny->SetReactState(REACT_PASSIVE);
                pBunny->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE |UNIT_FLAG_NOT_SELECTABLE);
                pBunny->CastSpell(pBunny, bPerfume ? SPELL_ALLURING_PERFUME_SPILL : SPELL_IRRESISTIBLE_COLOGNE_SPILL, true, NULL, NULL, me->GetGUID());
            }
        }

        void SpellHitTarget(Unit *pTarget, const SpellEntry *spell) 
        {
            if (spell->Id == SPELL_THROW_PERFUME)
                SummonBunny(pTarget, true);
            if (spell->Id == SPELL_THROW_COLOGNE)
                SummonBunny(pTarget, false);
        }

        void UpdateAI(const uint32 diff)
        {
            if (uiPhase == PHASE_INTRO)
            {
                if (uiWaitTimer <= diff)
                {
                    DoAction(START_FIGHT);
                } else uiWaitTimer -= diff;
            }
            else // PHASE_NORMAL
            {
                if (!UpdateVictim())
                    return;

                if (uiThrowTimer <= diff)
                {
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(pTarget, urand(0,1) ? SPELL_THROW_PERFUME : SPELL_THROW_COLOGNE, false);
                    uiThrowTimer = urand(5000, 7500);
                } else uiThrowTimer -= diff;

                if (uiThreatTimer <= diff)
                {
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                    {
                        me->getThreatManager().modifyThreatPercent(me->getVictim(), -100);
                        me->AddThreat(pTarget, 9999999.0f);
                    }
                    uiThreatTimer = urand(5000, 10000);
                } else uiThreatTimer -= diff;

                if (uiPingTimer <= diff)
                {
                    SetInCombat();
                    uiPingTimer = 5000;
                } else uiPingTimer -= diff;

                DoMeleeAttackIfReady();
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (!pInstance)
                return;

            if (Creature* pHummel = Unit::GetCreature(*me, pInstance->GetData64(DATA_HUMMEL)))
                pHummel->AI()->DoAction(APOTHECARY_DIED);
        }
    };
};

/*######
## npc_crazed_apothecary
######*/

class npc_crazed_apothecary : public CreatureScript
{
public:
    npc_crazed_apothecary() : CreatureScript("npc_crazed_apothecary") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_crazed_apothecaryAI(pCreature);
    }

    struct npc_crazed_apothecaryAI : public ScriptedAI
    {
        npc_crazed_apothecaryAI(Creature *c) : ScriptedAI(c) { }

        uint32 uiExplodeTimer;

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            SetInCombat();

            if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
            {
                uiExplodeTimer = urand (2500, 5000);
                me->GetMotionMaster()->MoveFollow(pTarget, 3.0f, float(urand(0, 4)));
            }
        }

        void SetInCombat()
        {
            Map *map = me->GetMap();
            if (!map->IsDungeon())
                return;

            bool found = false;

            Map::PlayerList const &PlayerList = map->GetPlayers();
            for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Player* i_pl = i->getSource())
                    if (!i_pl->isGameMaster() && i_pl->isAlive() && me->GetDistance(i_pl) <= 100)
                    {
                        me->SetInCombatWith(i_pl);
                        i_pl->SetInCombatWith(me);
                        me->AddThreat(i_pl, 1.0f);
                        found = true;
                    }
            }          
            if (!found)
                me->DespawnOrUnsummon(); // should never happen
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (uiExplodeTimer <= diff)
            {
                DoCast(me, SPELL_UNSTABLE_REACTION, false);
            } else uiExplodeTimer -= diff;
        }
    };
};
void AddSC_shadowfang_keep()
{
    new npc_shadowfang_prisoner();
    new npc_arugal_voidwalker();
    new npc_apothecary_hummel();
    new npc_apothecary_baxter();
    new npc_apothecary_frye();
    new npc_crazed_apothecary();
}
