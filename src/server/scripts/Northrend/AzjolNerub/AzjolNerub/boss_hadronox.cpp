/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
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

/*
* Comment: No Waves atm and the doors spells are crazy...
*
* When your group enters the main room (the one after the bridge), you will notice a group of 3 Nerubians.
* When you engage them, 2 more groups like this one spawn behind the first one - it is important to pull the first group back,
* so you don't aggro all 3. Hadronox will be under you, fighting Nerubians.
*
* This is the timed gauntlet - waves of non-elite spiders
* will spawn from the 3 doors located a little above the main room, and will then head down to fight Hadronox. After clearing the
* main room, it is recommended to just stay in it, kill the occasional non-elites that will attack you instead of the boss, and wait for
* Hadronox to make his way to you. When Hadronox enters the main room, she will web the doors, and no more non-elites will spawn.
*/

/*
WoW-Castle SQL:
DELETE FROM `spell_script_names` WHERE `spell_id` IN (59417, 53030);
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(53030, 'spell_leech_poison_hadronox'),
(59417, 'spell_leech_poison_hadronox');
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "azjol_nerub.h"

enum Spells
{
    SPELL_ACID_CLOUD                              = 53400, // Victim
    SPELL_LEECH_POISON                            = 53030, // Victim
    SPELL_PIERCE_ARMOR                            = 53418, // Victim
    SPELL_WEB_GRAB                                = 57731, // Victim
    H_SPELL_ACID_CLOUD                            = 59419,
    H_SPELL_LEECH_POISON                          = 59417,
    H_SPELL_WEB_GRAB                              = 59421,
    SPELL_LEECH_POISON_HEAL                       = 53800
};

enum CreatureIDs
{
    NPC_ANUBAR_CHAMPION = 29062,
    NPC_ANUBAR_CRYPT_FIEND = 29063,
    NPC_ANUBAR_NECROMANCER = 29098,
    BOSS_HADRONOX_ENTRY = 28921
};

enum AchievementID
{
    ACHIEVEMENT_HADRONOX_DENIED = 1297
};

const Position SpawnPoint = { 531.8f, 579.2f, 733.7f, 4.7f };
const Position CenterPoint = { 529.2f, 550.4f, 731.9f, 1.5f };

class boss_hadronox : public CreatureScript
{
public:
    boss_hadronox() : CreatureScript("boss_hadronox") { }

    struct boss_hadronoxAI : public ScriptedAI
    {
        boss_hadronoxAI(Creature* creature) : ScriptedAI(creature), Summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        SummonList Summons;

        uint32 uiAcidTimer;
        uint32 uiLeechTimer;
        uint32 uiPierceTimer;
        uint32 uiGrabTimer;
        uint32 uiDoorsTimer;
        uint32 uiSummonTimer;
        uint32 uiCheckTimer;

        bool bClosedDoor;

        void Reset()
        {
            me->SetHealth(me->GetMaxHealth());
            me->SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, 9.0f);
            me->SetFloatValue(UNIT_FIELD_COMBATREACH, 9.0f);

            uiAcidTimer = urand(10*IN_MILLISECONDS, 14*IN_MILLISECONDS);
            uiLeechTimer = urand(3*IN_MILLISECONDS, 9*IN_MILLISECONDS);
            uiPierceTimer = urand(1*IN_MILLISECONDS, 3*IN_MILLISECONDS);
            uiGrabTimer = urand(15*IN_MILLISECONDS, 19*IN_MILLISECONDS);
            uiDoorsTimer = urand(20*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            uiSummonTimer = 5*IN_MILLISECONDS;
            uiCheckTimer = 2*IN_MILLISECONDS;

            bClosedDoor = false;

            Summons.DespawnAll();

            if (instance && (instance->GetData(DATA_HADRONOX_EVENT) != DONE))
                instance->SetData(DATA_HADRONOX_EVENT, FAIL);
        }

        void JustDied(Unit* /*killer*/)
        {
            Summons.DespawnAll();

            if (instance)
            {
                instance->SetData(DATA_HADRONOX_EVENT, DONE);

                if (IsHeroic() && !bClosedDoor)
                {
                    instance->DoCompleteAchievement(ACHIEVEMENT_HADRONOX_DENIED);
                }
            }
        }

        void JustSummoned(Creature *summon)
        {
            if (summon)
            {
                Summons.Summon(summon);

                if (summon->AI())
                    summon->AI()->AttackStart(me);
            }
        }

        void SummonedCreatureDespawn(Creature *summon)
        {
            if (summon)
                Summons.Despawn(summon);
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (instance)
                instance->SetData(DATA_HADRONOX_EVENT, IN_PROGRESS);
        }

        bool CheckPlayersInDistance()
        {
            bool returnValue = false;

            if (me->GetMap())
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();

                if (me->GetMap()->IsDungeon() && !players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* player = itr->getSource();

                        // Only apply to attackable, alive and in 70.0 yards players
                        if (player && !player->isGameMaster() && player->isAlive() && me->IsValidAttackTarget(player))
                        {
                            if (player->GetDistance(CenterPoint) <= 70.0f)
                                returnValue = true;

                            // In combat with that player, check, that player does not get too far away
                            if (DoGetThreat(player))
                            {
                                if (player->GetDistance(CenterPoint) > 40.0f)
                                {
                                    player->NearTeleportTo(CenterPoint.GetPositionX(), CenterPoint.GetPositionY(), CenterPoint.GetPositionZ(), CenterPoint.GetOrientation());
                                }
                            }
                        }
                    }
                }
            }

            return returnValue;
        }

        void SummonAdds()
        {
            DoSummon(NPC_ANUBAR_CHAMPION, SpawnPoint, 30000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
            DoSummon(NPC_ANUBAR_CRYPT_FIEND, SpawnPoint, 30000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
            DoSummon(NPC_ANUBAR_NECROMANCER, SpawnPoint, 30000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);

            if (IsHeroic())
                DoSummon(NPC_ANUBAR_CRYPT_FIEND, SpawnPoint, 30000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
        }

        void UpdateAI(const uint32 diff)
        {
            if (uiCheckTimer <= diff)
            {
                if (CheckPlayersInDistance())
                {
                    if (!me->isInCombat())
                    {
                        SummonAdds();
                    }
                }
                else if (me->isInCombat())
                {
                    Summons.DespawnAll();
                    EnterEvadeMode();
                }

                uiCheckTimer = 2*IN_MILLISECONDS;
            } else uiCheckTimer -= diff;

            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (!bClosedDoor)
            {
                if (uiSummonTimer <= diff)
                {
                    SummonAdds();
                    uiSummonTimer = 5*IN_MILLISECONDS;
                } else uiSummonTimer -= diff;

                if (uiDoorsTimer <= diff)
                {
                    bClosedDoor = true;
                } else uiDoorsTimer -= diff;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiPierceTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_PIERCE_ARMOR);
                uiPierceTimer = 8*IN_MILLISECONDS;
            } else uiPierceTimer -= diff;

            if (uiAcidTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    DoCast(target, SPELL_ACID_CLOUD);

                uiAcidTimer = urand(20*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            } else uiAcidTimer -= diff;

            if (uiLeechTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    DoCast(target, SPELL_LEECH_POISON);

                uiLeechTimer = urand(11*IN_MILLISECONDS, 14*IN_MILLISECONDS);
            } else uiLeechTimer -= diff;

            if (uiGrabTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0)) // Draws all players (and attacking Mobs) to itself.
                    DoCast(target, SPELL_WEB_GRAB);

                uiGrabTimer = urand(15*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            } else uiGrabTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_hadronoxAI(creature);
    }
};

class spell_leech_poison_hadronox : public SpellScriptLoader
{
    public:
        spell_leech_poison_hadronox() : SpellScriptLoader("spell_leech_poison_hadronox") { }

        class spell_leech_poison_hadronox_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_leech_poison_hadronox_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                Unit* caster = GetCaster();

                if (!target || !caster || caster->GetEntry() != BOSS_HADRONOX_ENTRY)
                    return;

                if (!target->isAlive())
                {
                    caster->CastSpell(caster, SPELL_LEECH_POISON_HEAL, true);
                }
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_leech_poison_hadronox_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_LEECH, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_leech_poison_hadronox_AuraScript();
        }
};

void AddSC_boss_hadronox()
{
    new boss_hadronox;
    new spell_leech_poison_hadronox;
}
