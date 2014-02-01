/*
 *
 * Copyright (C) 2011-2014 ArkCORE <http://www.arkania.net/>
 *
 * Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
 *
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
SDName: Ashenvale
SD%Complete: 70
SDComment: Quest support: 6544, 6482
SDCategory: Ashenvale Forest
EndScriptData */

/* ContentData
npc_torek
npc_ruul_snowhoof
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

enum ashenvale
{
	QUEST_OF_THEIR_OWN_DESIGN						= 13595,
	NPC_BATHRANS_CORPSE								= 33183,

	QUEST_BATHED_IN_LIGHT							= 13642,
	GO_LIGHT_OF_ELUNE_AT_LAKE_FALATHIM				= 194651,
	ITEM_UNBATHED_CONCOCTION						= 45065,
	ITEM_BATHED_CONCOCTION							= 45066,

	QUEST_RESPECT_FOR_THE_FALLEN					= 13626,
	SPELL_CREATE_FEEROS_HOLY_HAMMER_COVER			= 62837,
	ITEM_FEEROS_HOLY_HAMMER							= 45042,
	SPELL_CREATE_THE_PURIFIERS_PRAYER_BOOK_COVER	= 62839,
	ITEM_PURIFIERS_PRAYER_BOOK						= 45043,
};

/*####
# npc_torek
####*/

enum Torek
{
    SAY_READY                  = 0,
    SAY_MOVE                   = 1,
    SAY_PREPARE                = 2,
    SAY_WIN                    = 3,
    SAY_END                    = 4,
    SPELL_REND                 = 11977,
    SPELL_THUNDERCLAP          = 8078,
    QUEST_TOREK_ASSULT         = 6544,
    NPC_SPLINTERTREE_RAIDER    = 12859,
    NPC_DURIEL                 = 12860,
    NPC_SILVERWING_SENTINEL    = 12896,
    NPC_SILVERWING_WARRIOR     = 12897,
    FACTION_QUEST              = 113
};

class npc_torek : public CreatureScript
{
public:
    npc_torek() : CreatureScript("npc_torek") { }

    struct npc_torekAI : public npc_escortAI
    {
        npc_torekAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() OVERRIDE
        {
            rend_Timer        = 5000;
            thunderclap_Timer = 8000;
            _completed        = false;
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE { }

        void JustSummoned(Creature* summoned) OVERRIDE
        {
            summoned->AI()->AttackStart(me);
        }

        void sQuestAccept(Player* player, Quest const* quest)
        {
            if (quest->GetQuestId() == QUEST_TOREK_ASSULT)
            {
                /// @todo find companions, make them follow Torek, at any time (possibly done by core/database in future?)
                Talk(SAY_READY, player);
                me->setFaction(FACTION_QUEST);
                npc_escortAI::Start(true, true, player->GetGUID());
            }
        }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            if (Player* player = GetPlayerForEscort())
            {
                switch (waypointId)
                {
                    case 1:
                        Talk(SAY_MOVE, player);
                        break;
                    case 8:
                        Talk(SAY_PREPARE, player);
                        break;
                    case 19:
                        /// @todo verify location and creatures amount.
                        me->SummonCreature(NPC_DURIEL, 1776.73f, -2049.06f, 109.83f, 1.54f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        me->SummonCreature(NPC_SILVERWING_SENTINEL, 1774.64f, -2049.41f, 109.83f, 1.40f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        me->SummonCreature(NPC_SILVERWING_WARRIOR, 1778.73f, -2049.50f, 109.83f, 1.67f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        break;
                    case 20:
                        Talk(SAY_WIN, player);
                        _completed = true;
                        player->GroupEventHappens(QUEST_TOREK_ASSULT, me);
                        break;
                    case 21:
                        Talk(SAY_END, player);
                        break;
                }
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (rend_Timer <= diff)
            {
                DoCastVictim(SPELL_REND);
                rend_Timer = 20000;
            } else rend_Timer -= diff;

            if (thunderclap_Timer <= diff)
            {
                DoCast(me, SPELL_THUNDERCLAP);
                thunderclap_Timer = 30000;
            } else thunderclap_Timer -= diff;
        }

    private:
        uint32 rend_Timer;
        uint32 thunderclap_Timer;
        bool   _completed;

    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_torekAI(creature);
    }
};

/*####
# npc_ruul_snowhoof
####*/

enum RuulSnowhoof
{
    NPC_THISTLEFUR_URSA         = 3921,
    NPC_THISTLEFUR_TOTEMIC      = 3922,
    NPC_THISTLEFUR_PATHFINDER   = 3926,
    QUEST_FREEDOM_TO_RUUL       = 6482,
    GO_CAGE                     = 178147
};

Position const RuulSnowhoofSummonsCoord[6] =
{
    { 3449.218018f, -587.825073f, 174.978867f, 4.714445f },
    { 3446.384521f, -587.830872f, 175.186279f, 4.714445f },
    { 3444.218994f, -587.835327f, 175.380600f, 4.714445f },
    { 3508.344482f, -492.024261f, 186.929031f, 4.145029f },
    { 3506.265625f, -490.531006f, 186.740128f, 4.239277f },
    { 3503.682373f, -489.393799f, 186.629684f, 4.349232f }
};

class npc_ruul_snowhoof : public CreatureScript
{
public:
    npc_ruul_snowhoof() : CreatureScript("npc_ruul_snowhoof") { }

    struct npc_ruul_snowhoofAI : public npc_escortAI
    {
        npc_ruul_snowhoofAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() OVERRIDE
        {
            if (GameObject* Cage = me->FindNearestGameObject(GO_CAGE, 20))
                Cage->SetGoState(GO_STATE_READY);
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE { }

        void JustSummoned(Creature* summoned) OVERRIDE
        {
            summoned->AI()->AttackStart(me);
        }

        void sQuestAccept(Player* player, Quest const* quest)
        {
            if (quest->GetQuestId() == QUEST_FREEDOM_TO_RUUL)
            {
                me->setFaction(FACTION_QUEST);
                npc_escortAI::Start(true, false, player->GetGUID());
            }
        }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 0:
                    me->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
                    if (GameObject* Cage = me->FindNearestGameObject(GO_CAGE, 20))
                        Cage->SetGoState(GO_STATE_ACTIVE);
                    break;
                case 13:
                    me->SummonCreature(NPC_THISTLEFUR_TOTEMIC, RuulSnowhoofSummonsCoord[0], TEMPSUMMON_DEAD_DESPAWN, 60000);
                    me->SummonCreature(NPC_THISTLEFUR_URSA, RuulSnowhoofSummonsCoord[1], TEMPSUMMON_DEAD_DESPAWN, 60000);
                    me->SummonCreature(NPC_THISTLEFUR_PATHFINDER, RuulSnowhoofSummonsCoord[2], TEMPSUMMON_DEAD_DESPAWN, 60000);
                    break;
                case 19:
                    me->SummonCreature(NPC_THISTLEFUR_TOTEMIC, RuulSnowhoofSummonsCoord[3], TEMPSUMMON_DEAD_DESPAWN, 60000);
                    me->SummonCreature(NPC_THISTLEFUR_URSA, RuulSnowhoofSummonsCoord[4], TEMPSUMMON_DEAD_DESPAWN, 60000);
                    me->SummonCreature(NPC_THISTLEFUR_PATHFINDER, RuulSnowhoofSummonsCoord[5], TEMPSUMMON_DEAD_DESPAWN, 60000);
                    break;
                case 21:
                    player->GroupEventHappens(QUEST_FREEDOM_TO_RUUL, me);
                    break;
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            npc_escortAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_ruul_snowhoofAI(creature);
    }
};

enum Muglash
{
    SAY_MUG_START1          = 0,
    SAY_MUG_START2          = 1,
    SAY_MUG_BRAZIER         = 2,
    SAY_MUG_BRAZIER_WAIT    = 3,
    SAY_MUG_ON_GUARD        = 4,
    SAY_MUG_REST            = 5,
    SAY_MUG_DONE            = 6,
    SAY_MUG_GRATITUDE       = 7,
    SAY_MUG_PATROL          = 8,
    SAY_MUG_RETURN          = 9,

    QUEST_VORSHA            = 6641,

    GO_NAGA_BRAZIER         = 178247,

    NPC_WRATH_RIDER         = 3713,
    NPC_WRATH_SORCERESS     = 3717,
    NPC_WRATH_RAZORTAIL     = 3712,

    NPC_WRATH_PRIESTESS     = 3944,
    NPC_WRATH_MYRMIDON      = 3711,
    NPC_WRATH_SEAWITCH      = 3715,

    NPC_VORSHA              = 12940,
    NPC_MUGLASH             = 12717
};

Position const FirstNagaCoord[3] =
{
    { 3603.504150f, 1122.631104f,  1.635f, 0.0f },        // rider
    { 3589.293945f, 1148.664063f,  5.565f, 0.0f },        // sorceress
    { 3609.925537f, 1168.759521f, -1.168f, 0.0f }         // razortail
};

Position const SecondNagaCoord[3] =
{
    { 3609.925537f, 1168.759521f, -1.168f, 0.0f },        // witch
    { 3645.652100f, 1139.425415f, 1.322f,  0.0f },        // priest
    { 3583.602051f, 1128.405762f, 2.347f,  0.0f }         // myrmidon
};

Position const VorshaCoord = {3633.056885f, 1172.924072f, -5.388f, 0.0f};

class npc_muglash : public CreatureScript
{
public:
    npc_muglash() : CreatureScript("npc_muglash") { }

    struct npc_muglashAI : public npc_escortAI
    {
        npc_muglashAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() OVERRIDE
        {
            eventTimer = 10000;
            waveId = 0;
            _isBrazierExtinguished = false;
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE
        {
            if (Player* player = GetPlayerForEscort())
                if (HasEscortState(STATE_ESCORT_PAUSED))
                {
                    if (urand(0, 1))
                        Talk(SAY_MUG_ON_GUARD, player);
                    return;
                }
        }

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
                if (Player* player = GetPlayerForEscort())
                    player->FailQuest(QUEST_VORSHA);
        }

        void JustSummoned(Creature* summoned) OVERRIDE
        {
            summoned->AI()->AttackStart(me);
        }

        void sQuestAccept(Player* player, Quest const* quest)
        {
            if (quest->GetQuestId() == QUEST_VORSHA)
            {
                Talk(SAY_MUG_START1);
                me->setFaction(FACTION_QUEST);
                npc_escortAI::Start(true, false, player->GetGUID());
            }
        }

            void WaypointReached(uint32 waypointId) OVERRIDE
            {
                if (Player* player = GetPlayerForEscort())
                {
                    switch (waypointId)
                    {
                        case 0:
                            Talk(SAY_MUG_START2, player);
                            break;
                        case 24:
                            Talk(SAY_MUG_BRAZIER, player);

                            if (GameObject* go = GetClosestGameObjectWithEntry(me, GO_NAGA_BRAZIER, INTERACTION_DISTANCE*2))
                            {
                                go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                                SetEscortPaused(true);
                            }
                            break;
                        case 25:
                            Talk(SAY_MUG_GRATITUDE);
                            player->GroupEventHappens(QUEST_VORSHA, me);
                            break;
                        case 26:
                            Talk(SAY_MUG_PATROL);
                            break;
                        case 27:
                            Talk(SAY_MUG_RETURN);
                            break;
                    }
                }
            }

            void DoWaveSummon()
            {
                switch (waveId)
                {
                    case 1:
                        me->SummonCreature(NPC_WRATH_RIDER,     FirstNagaCoord[0], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_WRATH_SORCERESS, FirstNagaCoord[1], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_WRATH_RAZORTAIL, FirstNagaCoord[2], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        break;
                    case 2:
                        me->SummonCreature(NPC_WRATH_PRIESTESS, SecondNagaCoord[0], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_WRATH_MYRMIDON,  SecondNagaCoord[1], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_WRATH_SEAWITCH,  SecondNagaCoord[2], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        break;
                    case 3:
                        me->SummonCreature(NPC_VORSHA, VorshaCoord, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        break;
                    case 4:
                        SetEscortPaused(false);
                        Talk(SAY_MUG_DONE);
                        break;
                }
            }

            void UpdateAI(uint32 diff) OVERRIDE
            {
                npc_escortAI::UpdateAI(diff);

                if (!me->GetVictim())
                {
                    if (HasEscortState(STATE_ESCORT_PAUSED) && _isBrazierExtinguished)
                    {
                        if (eventTimer < diff)
                        {
                            ++waveId;
                            DoWaveSummon();
                            eventTimer = 10000;
                        }
                        else
                            eventTimer -= diff;
                    }
                    return;
                }
                DoMeleeAttackIfReady();
            }

    private:
        uint32 eventTimer;
        uint8  waveId;
    public:
        bool   _isBrazierExtinguished;

    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_muglashAI(creature);
    }
};

class go_naga_brazier : public GameObjectScript
{
    public:
        go_naga_brazier() : GameObjectScript("go_naga_brazier") { }

        bool OnGossipHello(Player* /*player*/, GameObject* go) OVERRIDE
        {
            if (Creature* creature = GetClosestCreatureWithEntry(go, NPC_MUGLASH, INTERACTION_DISTANCE*2))
            {
                if (npc_muglash::npc_muglashAI* pEscortAI = CAST_AI(npc_muglash::npc_muglashAI, creature->AI()))
                {
                    creature->AI()->Talk(SAY_MUG_BRAZIER_WAIT);

                    pEscortAI->_isBrazierExtinguished = true;
                    return false;
                }
            }

            return true;
        }
};

/*####
# spell_potion_of_wildfire
####*/

class spell_potion_of_wildfire : public SpellScriptLoader
{
    public:
        spell_potion_of_wildfire() : SpellScriptLoader("spell_potion_of_wildfire") { }

        class spell_potion_of_wildfire_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_potion_of_wildfire_SpellScript);
			
			void HandleOnHit()
            {
				Player* player = GetCaster()->ToPlayer();
				if (!player) return;
				
				if (player->GetQuestStatus(QUEST_OF_THEIR_OWN_DESIGN) == QUEST_STATUS_INCOMPLETE)				
				{							
					if (Creature* creature = player->FindNearestCreature(NPC_BATHRANS_CORPSE, 10.0f, true))					
					{						
						player->KilledMonsterCredit(NPC_BATHRANS_CORPSE, NULL);	
					}
				}				
            }

			void Register() OVERRIDE
            {                
				OnHit += SpellHitFn(spell_potion_of_wildfire_SpellScript::HandleOnHit);				
            }


        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_potion_of_wildfire_SpellScript();
        }
};

/*####
# spell_unbathed_concoction
####*/

class spell_unbathed_concoction : public SpellScriptLoader
{
    public:
        spell_unbathed_concoction() : SpellScriptLoader("spell_unbathed_concoction") { }

        class spell_unbathed_concoction_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_unbathed_concoction_SpellScript);
			
			
            void Unload() OVERRIDE
            {				
				Player* player = GetCaster()->ToPlayer();
				if (!player) return;
				
				if (player->GetQuestStatus(QUEST_BATHED_IN_LIGHT) == QUEST_STATUS_INCOMPLETE)				
				{							
					if (GameObject* go = player->FindNearestGameObject(GO_LIGHT_OF_ELUNE_AT_LAKE_FALATHIM, 10.0f))					
					{						
						if (player->HasItemCount(ITEM_UNBATHED_CONCOCTION,1))
						{
							player->DestroyItemCount (ITEM_UNBATHED_CONCOCTION,1,true);
							player->AddItem(ITEM_BATHED_CONCOCTION,1);
						}						
					}
				}				
            }

			
			void Register() OVERRIDE {}

        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_unbathed_concoction_SpellScript();
        }
};

/*####
# npc_feero_ironhand
####*/

class npc_feero_ironhand : public CreatureScript
{
    public:
        npc_feero_ironhand() : CreatureScript("npc_feero_ironhand") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_RESPECT_FOR_THE_FALLEN) == QUEST_STATUS_INCOMPLETE)				
			{			
				if (!player->HasItemCount(ITEM_FEEROS_HOLY_HAMMER,1))
				{							
					player->CastSpell (creature, SPELL_CREATE_FEEROS_HOLY_HAMMER_COVER);	
					player->AddItem(ITEM_FEEROS_HOLY_HAMMER,1);					
				}						
			}
			return true;
		}
};

/*####
# npc_delgren_the_purifier
####*/

class npc_delgren_the_purifier : public CreatureScript
{
    public:
        npc_delgren_the_purifier() : CreatureScript("npc_delgren_the_purifier") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_RESPECT_FOR_THE_FALLEN) == QUEST_STATUS_INCOMPLETE)				
			{			
				if (!player->HasItemCount(ITEM_PURIFIERS_PRAYER_BOOK,1))
				{							
					player->CastSpell (creature, SPELL_CREATE_THE_PURIFIERS_PRAYER_BOOK_COVER);						
					player->AddItem(ITEM_PURIFIERS_PRAYER_BOOK,1);
				}						
			}
			return true;
		}
};


void AddSC_ashenvale()
{
    new npc_torek();
    new npc_ruul_snowhoof();
    new npc_muglash();
    new go_naga_brazier();
	new spell_potion_of_wildfire();
	new spell_unbathed_concoction();
	new npc_feero_ironhand();
	new npc_delgren_the_purifier();

}
