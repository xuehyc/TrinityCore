/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
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
 * Comment: Find in the future best timers and the event is not implemented.
 */

#include "ScriptPCH.h"
#include "azjol_nerub.h"

enum Spells
{
    // krikthir
    SPELL_MIND_FLAY                               = 52586,
    H_SPELL_MIND_FLAY                             = 59367,
    SPELL_CURSE_OF_FATIGUE                        = 52592,
    H_SPELL_CURSE_OF_FATIGUE                      = 59368,
    SPELL_FRENZY                                  = 28747,
    SPELL_SWARM                                   = 52440, // ( 52438,52439,52440,52448,52449,52450 )
    // skittering infector
    SPELL_ACID_SPLASH                             = 52446,
    H_SPELL_ACID_SPLASH                           = 59363,
    // anub'ar skirmisher
    SPELL_FIXATE                                  = 52537,
    SPELL_CHARGE                                  = 52538,
    SPELL_BACKSTAB                                = 52540,
    // anub'ar shadowcaster
    SPELL_SHADOW_BOLT                             = 52534,
    H_SPELL_SHADOW_BOLT                           = 59357,
    SPELL_SHADOW_NOVA                             = 52535,
    H_SPELL_SHADOW_NOVA                           = 59358,
    // anub'ar warrior 
    SPELL_STRIKE                                  = 52532,
    SPELL_CLEAVE                                  = 49806,
    // common watcher spells
    SPELL_WEB_WRAP                                = 52086,
    SPELL_WEB_WRAP_STUN                           = 52087,    
    SPELL_INFECTED_BITE                           = 52469,
    H_SPELL_INFECTED_BITE                         = 59364,
    // gashra
    SPELL_ENRAGE                                  = 52470,
    // narjil
    SPELL_BLINDING_WEBS                           = 52524,
    H_SPELL_BLINDING_WEBS                         = 59365,
    // silthik
    SPELL_POSION_SPRAY                            = 52493,
    H_SPELL_POSION_SPRAY                          = 59366
};

enum Mobs
{
    MOB_SKITTERING_SWARMER                        = 28735,
    MOB_SKITTERING_SWARMER_CONTROLLER             = 32593,
    MOB_SKITTERING_INFECTOR                       = 28736
};

enum Yells
{
    SAY_AGGRO                                     = -1601011,
    SAY_SLAY_1                                    = -1601012,
    SAY_SLAY_2                                    = -1601013,
    SAY_DEATH                                     = -1601014,
    SAY_SWARM_1                                   = -1601015,
    SAY_SWARM_2                                   = -1601016,
    SAY_PREFIGHT_1                                = -1601017,
    SAY_PREFIGHT_2                                = -1601018,
    SAY_PREFIGHT_3                                = -1601019,
    SAY_SEND_GROUP_1                              = -1601020,
    SAY_SEND_GROUP_2                              = -1601021,
    SAY_SEND_GROUP_3                              = -1601022
};

enum Misc
{
    ACHIEV_WATCH_HIM_DIE                          = 1296
};

class boss_krik_thir : public CreatureScript
{
public:
    boss_krik_thir() : CreatureScript("boss_krik_thir") { }

    struct boss_krik_thirAI : public ScriptedAI
    {
        boss_krik_thirAI(Creature *c) : ScriptedAI(c), lSummons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 uiMindFlayTimer;
        uint32 uiCurseFatigueTimer;
        uint32 uiSummonTimer;

        SummonList lSummons;

        bool bFrenzy;

        void Reset()
        {
            bFrenzy = false;
            uiSummonTimer = 10*IN_MILLISECONDS;
            uiMindFlayTimer = 12*IN_MILLISECONDS;
            uiCurseFatigueTimer = 7*IN_MILLISECONDS;

            lSummons.DespawnAll();

            if (pInstance)
                pInstance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);

            if (pInstance)
                pInstance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, IN_PROGRESS);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            if (uiSummonTimer <= diff)
            {
                DoScriptText(RAND(SAY_SWARM_1, SAY_SWARM_2), me);

                DoCast(me, SPELL_SWARM, false);
                uiSummonTimer = urand(20*IN_MILLISECONDS, 25*IN_MILLISECONDS);
            } else uiSummonTimer -= diff;

            if (uiMindFlayTimer <= diff)
            {
                    DoCast(me->getVictim(), SPELL_MIND_FLAY);
                    uiMindFlayTimer = urand(10*IN_MILLISECONDS, 15*IN_MILLISECONDS);
                } else uiMindFlayTimer -= diff;

            if (uiCurseFatigueTimer <= diff)
            {
                Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true);

                DoCast(pTarget, SPELL_CURSE_OF_FATIGUE);

                uiCurseFatigueTimer = 20*IN_MILLISECONDS;
            } else uiCurseFatigueTimer -= diff;

            if (!bFrenzy && HealthBelowPct(20))
            {
                me->InterruptNonMeleeSpells(true);
                DoCast(me, SPELL_FRENZY, true);
                bFrenzy = true;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (!pInstance)
                return;

            pInstance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, DONE);

            //Achievement: Watch him die
            Creature *pAdd = Unit::GetCreature(*me, pInstance->GetData64(DATA_WATCHER_GASHRA));
            if (!pAdd || !pAdd->isAlive())
                return;

            pAdd = Unit::GetCreature(*me, pInstance->GetData64(DATA_WATCHER_SILTHIK));
            if (!pAdd || !pAdd->isAlive())
                return;

            pAdd = Unit::GetCreature(*me, pInstance->GetData64(DATA_WATCHER_NARJIL));
            if (!pAdd || !pAdd->isAlive())
                return;

            pInstance->DoCompleteAchievement(ACHIEV_WATCH_HIM_DIE);
        }

        void KilledUnit(Unit * victim)
        {
            if (victim == me)
                return;

            DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
        }

        void JustSummoned(Creature* summoned)
        {
            summoned->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
            lSummons.Summon(summoned);
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new boss_krik_thirAI(creature);
    }
};

class npc_skittering_infector : public CreatureScript
{
public:
    npc_skittering_infector() : CreatureScript("npc_skittering_infector") { }

    struct npc_skittering_infectorAI : public ScriptedAI
    {
        npc_skittering_infectorAI(Creature *c) : ScriptedAI(c) {}

        void JustDied(Unit* /*killer*/)
        {
            //The spell is not working properly
            DoCast(me->getVictim(), SPELL_ACID_SPLASH, true);
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_skittering_infectorAI(creature);
    }
};

class npc_anub_ar_skirmisher : public CreatureScript
{
public:
    npc_anub_ar_skirmisher() : CreatureScript("npc_anub_ar_skirmisher") { }

    struct npc_anub_ar_skirmisherAI : public ScriptedAI
    {
        npc_anub_ar_skirmisherAI(Creature *c) : ScriptedAI(c) {}

        uint32 uiChargeTimer;
        uint32 uiBackstabTimer;

        void Reset()
        {
            uiChargeTimer   = 10*IN_MILLISECONDS;
            uiBackstabTimer = 7*IN_MILLISECONDS;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (uiChargeTimer <= diff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                {
                    DoCast(pTarget, SPELL_CHARGE, true);
                    pTarget->CastSpell(me, SPELL_FIXATE, true);
                }
                uiChargeTimer = 15*IN_MILLISECONDS;
            } else uiChargeTimer -= diff;

            if (uiBackstabTimer <= diff)
            {
                if (me->getVictim()->isInBackInMap(me, 5.0f, 1.5f))
                    DoCast(me->getVictim(), SPELL_BACKSTAB);
                uiBackstabTimer = 5*IN_MILLISECONDS;
            } else uiBackstabTimer -= diff;

            DoMeleeAttackIfReady();

        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_anub_ar_skirmisherAI(creature);
    }
};

class npc_anub_ar_shadowcaster : public CreatureScript
{
public:
    npc_anub_ar_shadowcaster() : CreatureScript("npc_anub_ar_shadowcaster") { }

    struct npc_anub_ar_shadowcasterAI : public ScriptedAI
    {
        npc_anub_ar_shadowcasterAI(Creature *c) : ScriptedAI(c) {}

        uint32 uiShadowBoltTimer;
        uint32 uiShadowNovaTimer;

        void Reset()
        {
            uiShadowBoltTimer = 6*IN_MILLISECONDS;
            uiShadowNovaTimer = 12*IN_MILLISECONDS;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (uiShadowBoltTimer <= diff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                     DoCast(pTarget, SPELL_SHADOW_BOLT);
                uiShadowBoltTimer = 6*IN_MILLISECONDS;
            } else uiShadowBoltTimer -= diff;

            if (uiShadowNovaTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_SHADOW_NOVA, true);
                uiShadowNovaTimer = 15*IN_MILLISECONDS;
            } else uiShadowNovaTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_anub_ar_shadowcasterAI(creature);
    }
};

class npc_anub_ar_warrior : public CreatureScript
{
public:
    npc_anub_ar_warrior() : CreatureScript("npc_anub_ar_warrior") { }

    struct npc_anub_ar_warriorAI : public ScriptedAI
    {
        npc_anub_ar_warriorAI(Creature *c) : ScriptedAI(c){}

        uint32 uiCleaveTimer;
        uint32 uiStrikeTimer;

        void Reset()
        {
            uiCleaveTimer = 9*IN_MILLISECONDS;
            uiStrikeTimer = 6*IN_MILLISECONDS;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (uiStrikeTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_STRIKE, true);
                uiStrikeTimer = 9*IN_MILLISECONDS;
            } else uiStrikeTimer -= diff;

            if (uiCleaveTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_CLEAVE, true);
                uiCleaveTimer = 12*IN_MILLISECONDS;
            } else uiCleaveTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_anub_ar_warriorAI(creature);
    }
};

class npc_krikthir_watcher : public CreatureScript
{
public:
    npc_krikthir_watcher() : CreatureScript("npc_krikthir_watcher") { }

    struct npc_krikthir_watcherAI : public ScriptedAI
    {
        npc_krikthir_watcherAI(Creature *c) : ScriptedAI(c) 
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 uiWebWrapTimer;
        uint32 uiInfectedBiteTimer;
        uint32 uiSpecialSpell;
        uint32 uiSpecialSpellTimer;

        uint32 uiEnwrapTimer;
        bool bEnwrapping;
        uint64 uiWrapTarget;

        void Reset()
        {
            switch (me->GetEntry())
            {
                // watcher narjil
                case 28729:
                    uiSpecialSpell = DUNGEON_MODE(SPELL_BLINDING_WEBS, H_SPELL_BLINDING_WEBS);
                    break;
                // watcher gashra
                case 28730:
                    me->setFaction(14);
                    uiSpecialSpell = SPELL_ENRAGE;
                    break;
                // watcher silthik
                case 28731: 
                    uiSpecialSpell = DUNGEON_MODE(SPELL_POSION_SPRAY, H_SPELL_POSION_SPRAY);
                    break;
                default:
                    uiSpecialSpell = 0;
                    break;
            }

            uiWebWrapTimer      = 10*IN_MILLISECONDS;
            uiInfectedBiteTimer = 6*IN_MILLISECONDS;
            uiSpecialSpellTimer = 15*IN_MILLISECONDS;

            uiEnwrapTimer       = 3*IN_MILLISECONDS;
            uiWrapTarget        = NULL;
            bEnwrapping         = false;

            if (pInstance)
                pInstance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (!pInstance)
                return;

            Creature *pKrikthir = Unit::GetCreature(*me, pInstance->GetData64(DATA_KRIKTHIR_THE_GATEWATCHER));
            if (pKrikthir && pKrikthir->isAlive())
                DoScriptText(RAND(SAY_SEND_GROUP_1, SAY_SEND_GROUP_2, SAY_SEND_GROUP_3), pKrikthir);

            pInstance->SetData(DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, SPECIAL);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (bEnwrapping)
            {
                if (uiEnwrapTimer <= diff)
                {
                    if (Unit* pTarget = Unit::GetUnit((*me), uiWrapTarget))
                    {
                        pTarget->CastSpell(pTarget, SPELL_WEB_WRAP_STUN, true);
                        uiWrapTarget = NULL;
                    }
                    bEnwrapping = false;
                    uiEnwrapTimer = 3*IN_MILLISECONDS;
                } else uiEnwrapTimer -= diff;
            }

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            if (uiWebWrapTimer <= diff)
            {
                Unit *pTarget = NULL;
                std::list<Unit *> playerList;
                SelectTargetList(playerList, 5, SELECT_TARGET_RANDOM, 40, true);
                for (std::list<Unit*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                {
                    pTarget = (*itr);
                    if (!pTarget->HasAura(SPELL_WEB_WRAP) && !pTarget->HasAura(SPELL_WEB_WRAP_STUN))
                        break;  // found someone

                    pTarget = NULL;
                }
                // if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 40, true, -SPELL_WEB_WRAP_STUN)
                if (pTarget)
                {
                    bEnwrapping = true;
                    uiWrapTarget = pTarget->GetGUID();
                    DoCast(pTarget, SPELL_WEB_WRAP, false);
                }
                uiWebWrapTimer = 15*IN_MILLISECONDS;
            } else uiWebWrapTimer -= diff;

            if (uiInfectedBiteTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_INFECTED_BITE, true);
                uiInfectedBiteTimer = 15*IN_MILLISECONDS;
            } else uiInfectedBiteTimer -= diff;

            if (uiSpecialSpell)
                if (uiSpecialSpellTimer <= diff)
                {
                    DoCast(uiSpecialSpell);
                    uiSpecialSpellTimer = 20*IN_MILLISECONDS;
                } else uiSpecialSpellTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_krikthir_watcherAI(creature);
    }
};

class npc_web_wrap : public CreatureScript
{
public:
    npc_web_wrap() : CreatureScript("npc_web_wrap") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_web_wrapAI(pCreature);
    }

    struct npc_web_wrapAI : public ScriptedAI
    {
        npc_web_wrapAI(Creature *c) : ScriptedAI(c) {}

        uint64 uiWrapTargetGUID;

        void Reset()
        { 
            uiWrapTargetGUID = 0; 
        }

        void EnterCombat(Unit* /*who*/) {}
        void AttackStart(Unit* /*who*/) {}
        void MoveInLineOfSight(Unit* /*who*/) {}

        void JustDied(Unit *killer)
        {
            if (uiWrapTargetGUID)
            {
                Unit* pTarget = Unit::GetUnit((*me), uiWrapTargetGUID);
                if (pTarget)
                    pTarget->RemoveAurasDueToSpell(SPELL_WEB_WRAP_STUN);
            }
            me->RemoveCorpse();
        }

        void UpdateAI(const uint32 /*diff*/)
        {
            // should not be here?
            if (Unit* pSummoner = CAST_SUM(me)->GetSummoner())
                uiWrapTargetGUID = pSummoner->GetGUID();

            Unit* temp = Unit::GetUnit((*me), uiWrapTargetGUID);
            if ((temp && temp->isAlive() && !temp->HasAura(SPELL_WEB_WRAP_STUN)) || !temp)
                me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }
    };

};

void AddSC_boss_krik_thir()
{
    new boss_krik_thir();
    new npc_krikthir_watcher();
    new npc_skittering_infector();
    new npc_anub_ar_warrior();
    new npc_anub_ar_skirmisher();
    new npc_anub_ar_shadowcaster();
    new npc_web_wrap();
}
