#include "ScriptPCH.h"
#include "icecrown_citadel.h"
#define GOSSIP_START_EVENT "We are prepared, Highlord. Let us battle for the fate of Azeroth! For the light of dawn!"

enum Yells
{
    SAY_INTRO_1_KING         = -1810001,
    SAY_INTRO_2_TIRION       = -1810002,
    SAY_INTRO_3_KING         = -1810003,
    SAY_INTRO_4_TIRION       = -1810004,
    SAY_INTRO_5_KING         = -1810005,
    SAY_AGGRO_KING           = -1810006,
    SAY_REMORSELESS_WINTER   = -1810007,
    SAY_RANDOM_1             = -1810008,
    SAY_RANDOM_2             = -1810009,
    SAY_KILL_1               = -1810010,
    SAY_KILL_2               = -1810011,
    SAY_BERSERK              = -1810012,
    SAY_ENDING_1_KING        = -1810013,
    SAY_ENDING_2_KING        = -1810014,
    SAY_ENDING_3_KING        = -1810015,
    SAY_ENDING_4_KING        = -1810016,
    SAY_ENDING_5_TIRION      = -1810017,
    SAY_ENDING_6_KING        = -1810018,
    SAY_ENDING_8_TIRION      = -1810020,
    SAY_ENDING_9_FATHER      = -1810021,
    SAY_ENDING_10_TIRION     = -1810022,
    SAY_ENDING_11_FATHER     = -1810023,
    SAY_ENDING_12_KING       = -1810024,
    SAY_DEATH_KING           = -1810025,
    SAY_ESCAPE_FROSTMOURNE   = -1810026,
    SAY_HARVEST_SOUL         = -1810027,
    SAY_DEVOURED_FROSTMOURNE = -1810028,
    SAY_SUMMON_VALKYR        = -1810029,
    SAY_BROKEN_ARENA         = -1810030,
    SAY_10_PROZENT           = -1810031
};

enum Spells
{
    SPELL_SUMMON_SHAMBLING_HORROR    = 70372,
    SPELL_SUMMON_DRUDGE_GHOULS       = 70359,
    SPELL_SUMMON_ICE_SPEHERE         = 69103,
    SPELL_SUMMON_RAGING_SPIRIT       = 69200,
    SPELL_SUMMON_VALKYR              = 69037,
    SPELL_SUMMON_DEFILE              = 72762,
    SPELL_SUMMON_VILE_SPIRIT         = 70498,
    SPELL_SUMMON_BROKEN_FROSTMOURNE  = 72406,
    SPELL_SUMMON_SHADOW_TRAP         = 73539,
    SPELL_INFEST                     = 70541,
    SPELL_NECROTIC_PLAGUE            = 70337,
    SPELL_PLAGUE_SIPHON              = 74074,
    SPELL_REMORSELES_WINTER          = 68981,
    SPELL_PAIN_AND_SUFFERING         = 72133,
    SPELL_WINGS_OF_THE_DAMNED        = 74352,
    SPELL_SOUL_REAPER                = 69409,
    SPELL_HARVEST_SOUL_TELEPORT      = 71372,
    SPELL_HARVEST_SOULS              = 74325,
    SPELL_QUAKE                      = 72262,
    SPELL_CHANNEL_KING               = 71769,
    SPELL_BROKEN_FROSTMOURNE         = 72398,
    SPELL_BOOM_VISUAL                = 72726,
    SPELL_ICEBLOCK_TRIGGER           = 71614,
    SPELL_TIRION_LIGHT               = 71797,
    SPELL_FROSTMOURNE_TRIGGER        = 72405,
    SPELL_DISENGAGE                  = 61508,
    SPELL_FURY_OF_FROSTMOURNE        = 70063,
    SPELL_REVIVE_VISUAL              = 37755,
    SPELL_REVIVE                     = 72423,
    SPELL_CLONE_PLAYER               = 57507,
    SPELL_RAGING_SPIRIT_VISUAL       = 69198,
    SPELL_DEFILE                     = 72743,
    SPELL_ICE_SPHERE_VISUAL          = 69090,
    SPELL_ICE_PULSE                  = 69099,
    SPELL_ICE_BURST                  = 69108,
    SPELL_LIFE_SIPHON                = 73783,
    SPELL_SOUL_SHRIEK                = 69242,
    SPELL_WHOCKVAWE                  = 72149,
    SPELL_ENRAGE                     = 72143,
    SPELL_BURST                      = 70503
};

struct Position MovePos[]=
{
    {461.792633f, -2125.855957f, 1040.860107f, 0.0f}, // move
    {503.156525f, -2124.516602f, 1040.860107f, 0.0f}, // move ending
    {490.110779f, -2124.989014f, 1040.860352f, 0.0f}, // move tirion frostmourne
    {478.333466f, -2124.618652f, 1040.859863f, 0.0f}, // move tirion attack
    {498.004486f, 2201.573486f, 1046.093872f, 0.0f}  // move valkyr
};

struct Locations
{
    float x,y,z;
};

static Locations TeleportPoint[]=
{
    {959.996f, 212.576f, 193.843f},
    {932.537f, 231.813f, 193.838f},
    {958.675f, 254.767f, 193.822f},
    {946.955f, 201.316f, 192.535f},
    {944.294f, 149.676f, 197.551f},
    {930.548f, 284.888f, 193.367f},
    {965.997f, 278.398f, 195.777f},
};

Creature* pLichKing;
Creature* pTirion;
Creature* pFather;
Creature* pFrostmourne;
Creature* pSafeZone;

class boss_the_lich_king : public CreatureScript
{
    public:
        boss_the_lich_king() : CreatureScript("boss_the_lich_king") { }

        struct boss_the_lich_kingAI : public BossAI
        {
            boss_the_lich_kingAI(Creature* pCreature) : BossAI(pCreature, DATA_THE_LICH_KING), summons(me)
            {
                pInstance = me->GetInstanceScript();
                pLichKing = me;
            }

            void Reset()
            {
                me->SetReactState(REACT_PASSIVE);

                m_uiPhase = 1;
                m_uiRandomSpeechTimer = 33000;
                m_uiBerserkTimer = 900000;
                m_uiSummonShamblingHorrorTimer = 20000;
                m_uiSummonDrudgeGhoulsTimer = 30000;
                m_uiInfestTimer = 30000;
                m_uiNecroticPlagueTimer = 30000;
                m_uiPlagueSiphonTimer = 5000;
                m_uiTirionSpawnTimer = 5000;
                m_uiQuakeTimer = 3000;
                m_uiIcePulsSummonTimer = 10000;
                m_uiPainandSufferingTimer = 10000;
                m_uiSummonSpiritTimer = 18000;
                m_uiSummonValkyrTimer = 20000;
                m_uiSoulReaperTimer = 15000;
                m_uiDefileTimer = 25000;
                m_uiInfestTimer = 40000;
                m_uiSummonVileSpiritTimer = 30000;
                m_uiHarvestSoulTimer = 70000;
                m_uiFrostGramPortTimer = 900000;
                m_uiSummonShadowTrap = 20000;
                m_uiEndingTimer = 1000;
                m_uiEndingPhase = 1;
                stage = 1;

                TriggerSpawned = false;
                TransitionPhase1 = false;
                TransitionPhase2 = false;
                TransitionPhase3 = false;
                bEnding = false;

                if(pInstance)
                    if(me->isAlive())
                        pInstance->SetData(DATA_THE_LICH_KING, NOT_STARTED);

                summons.DespawnAll();

                me->SetSpeed(MOVE_RUN, 1.8f);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED);
            }

            void EnterCombat(Unit* /*pWho*/)
            {
                DoScriptText(SAY_AGGRO_KING, me);
            }

            void JustDied(Unit* /*pKiller*/)
            {
                DoScriptText(SAY_DEATH_KING, me);

                if(pInstance)
                    pInstance->SetData(DATA_THE_LICH_KING, DONE);

                summons.DespawnAll();

                PlayerCinematic();
            }

            void PlayerCinematic()
            {
                Map::PlayerList const &PlList = me->GetMap()->GetPlayers();

                if (PlList.isEmpty())
                    return;

                for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
                {
                    if (Player* pPlayer = i->getSource())
                    {
                        if(pPlayer)
                        {
                            pPlayer->SendMovieStart(16);
                        }
                    }
                }
            }

            void JustReachedHome()
            {
                if(pInstance)
                    pInstance->SetData(DATA_THE_LICH_KING, FAIL);

                summons.DespawnAll();
            }

            void KilledUnit(Unit* victim)
            {
                if(!TransitionPhase3)
                {
                    if (victim->GetTypeId() == TYPEID_PLAYER)
                    {
                        switch(rand()%1)
                        {
                            case 0: DoScriptText(SAY_KILL_1, me); break;
                            case 1: DoScriptText(SAY_KILL_2, me); break;
                        }
                    }
                }
            }

            void JustSummoned(Creature* summoned)
            {
                float x,y,z;
                if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM,1))
                {
                    target->GetPosition(x,y,z);
                    summoned->AddThreat(target, 1000.0f);
                    summoned->GetMotionMaster()->MovePoint(0,x,y,z);
                }
                summons.Summon(summoned);
            }

            void Phasenswitch()
            {
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();
                me->GetMotionMaster()->MovePoint(0, MovePos[1]);
            }

            void PlayerRevive()
            {
                Map::PlayerList const &PlList = pFather->GetMap()->GetPlayers();

                if (PlList.isEmpty())
                    return;

                for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
                {
                    if (Player* pPlayer = i->getSource())
                    {
                        if (pPlayer && pPlayer->isDead())
                        {
                            pFather->CastSpell(pPlayer, SPELL_REVIVE, true);
                        }
                    }
                }
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if(!TransitionPhase3)
                {
                    if (m_uiRandomSpeechTimer < uiDiff)
                    {
                        DoScriptText(RAND(SAY_RANDOM_1,SAY_RANDOM_2), me);
                        m_uiRandomSpeechTimer = 33000;
                    } else m_uiRandomSpeechTimer -= uiDiff;
                }

                if (m_uiBerserkTimer < uiDiff)
                {
                    DoScriptText(SAY_BERSERK, me);
                    DoCast(me, SPELL_BERSERK);
                    m_uiBerserkTimer = 900000;
                } else m_uiBerserkTimer -= uiDiff;

                if(m_uiPhase == 1)
                {
                    if (IsHeroic())
                    {
                        if (m_uiSummonShadowTrap < uiDiff)
                        {
                            if(Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                                DoCast(pTarget, SPELL_SUMMON_SHADOW_TRAP, true);
                            m_uiSummonShadowTrap = 30000;
                        } else m_uiSummonShadowTrap -= uiDiff;
                    }

                    if (m_uiInfestTimer < uiDiff)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            DoCast(pTarget, SPELL_INFEST);
                        m_uiInfestTimer = 30000;
                    } else m_uiInfestTimer -= uiDiff;

                    if (m_uiPlagueSiphonTimer < uiDiff)
                    {
                        DoCast(me, SPELL_PLAGUE_SIPHON);
                        m_uiPlagueSiphonTimer = 30000;
                    } else m_uiPlagueSiphonTimer -= uiDiff;

                    if (m_uiSummonDrudgeGhoulsTimer < uiDiff)
                    {
                        DoCast(SPELL_SUMMON_DRUDGE_GHOULS);
                        m_uiSummonDrudgeGhoulsTimer = 20000;
                    } else m_uiSummonDrudgeGhoulsTimer -= uiDiff;

                    if (m_uiSummonShamblingHorrorTimer < uiDiff)
                    {
                        DoCast(me, SPELL_SUMMON_SHAMBLING_HORROR);
                        m_uiSummonShamblingHorrorTimer = 30000;
                    } else m_uiSummonShamblingHorrorTimer -= uiDiff;

                    if (m_uiNecroticPlagueTimer < uiDiff)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            DoCast(pTarget, SPELL_NECROTIC_PLAGUE);
                        m_uiNecroticPlagueTimer = 30000;
                    } else m_uiNecroticPlagueTimer -= uiDiff;
                }

                if(m_uiPhase == 2) //transition phase 1
                {
                    if (m_uiQuakeTimer < uiDiff)
                    {
                        switch (stage)
                        {
                            case 1:
                            {
                                DoScriptText(SAY_REMORSELESS_WINTER, me);
                                DoCast(me, SPELL_REMORSELES_WINTER);
                                m_uiQuakeTimer = 60000;
                                ++stage;
                            }
                            break;
                            case 2:
                            {
                                DoScriptText(SAY_BROKEN_ARENA, me);
                                DoCast(SPELL_QUAKE);
                                m_uiQuakeTimer = 1000;
                                --stage;
                                m_uiPhase = 3;
                            }
                            break;
                        }
                    } else m_uiQuakeTimer -= uiDiff;

                    if (m_uiSummonSpiritTimer < uiDiff)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            DoCast(pTarget, SPELL_SUMMON_RAGING_SPIRIT);
                        m_uiSummonSpiritTimer = 16000;
                    } else m_uiSummonSpiritTimer -= uiDiff;

                    if (m_uiIcePulsSummonTimer < uiDiff)
                    {
                        DoCast(SPELL_SUMMON_ICE_SPEHERE);
                        m_uiIcePulsSummonTimer = 15000;
                    } else m_uiIcePulsSummonTimer -= uiDiff;

                    if (m_uiPainandSufferingTimer < uiDiff)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            DoCast(pTarget, SPELL_PAIN_AND_SUFFERING);
                        m_uiPainandSufferingTimer = 2000;
                    } else m_uiPainandSufferingTimer -= uiDiff;
                }

                if(m_uiPhase == 3)
                {
                    if (m_uiDefileTimer < uiDiff)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            DoCast(pTarget, SPELL_SUMMON_DEFILE);
                        m_uiDefileTimer = 20000;
                    } else m_uiDefileTimer -= uiDiff;

                    if (m_uiSummonValkyrTimer < uiDiff)
                    {
                        DoScriptText(SAY_SUMMON_VALKYR, me);
                        DoCast(me, SPELL_SUMMON_VALKYR);
                        m_uiSummonValkyrTimer = 20000;
                    } else m_uiSummonValkyrTimer -= uiDiff;

                    if (m_uiSoulReaperTimer < uiDiff)
                    {
                        DoCast(me->getVictim(), SPELL_SOUL_REAPER);
                        m_uiSoulReaperTimer = 20000;
                    } else m_uiSoulReaperTimer -= uiDiff;

                    if (m_uiInfestTimer < uiDiff)
                    {
                        DoCast(me, SPELL_INFEST);
                        m_uiInfestTimer = 30000;
                    } else m_uiInfestTimer -= uiDiff;
                }

                if(m_uiPhase == 4) //transition phase 1
                {
                    if (m_uiQuakeTimer < uiDiff)
                    {
                        switch (stage)
                        {
                            case 1:
                            {
                                DoScriptText(SAY_REMORSELESS_WINTER, me);
                                DoCast(me, SPELL_REMORSELES_WINTER);
                                m_uiQuakeTimer = 60000;
                                ++stage;
                            }
                            break;
                            case 2:
                            {
                                DoScriptText(SAY_BROKEN_ARENA, me);
                                DoCast(SPELL_QUAKE);
                                m_uiQuakeTimer = 1000;
                                --stage;
                                m_uiPhase = 5;
                            }
                            break;
                        }
                    } else m_uiQuakeTimer -= uiDiff;

                    if (m_uiSummonSpiritTimer < uiDiff)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            DoCast(pTarget, SPELL_SUMMON_RAGING_SPIRIT);
                        m_uiSummonSpiritTimer = 16000;
                    } else m_uiSummonSpiritTimer -= uiDiff;

                    if (m_uiIcePulsSummonTimer < uiDiff)
                    {
                        DoCast(me, SPELL_SUMMON_ICE_SPEHERE);
                        m_uiIcePulsSummonTimer = 15000;
                    } else m_uiIcePulsSummonTimer -= uiDiff;

                    if (m_uiPainandSufferingTimer < uiDiff)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            DoCast(pTarget, SPELL_PAIN_AND_SUFFERING);
                        m_uiPainandSufferingTimer = 3000;
                    } else m_uiPainandSufferingTimer -= uiDiff;
                }

                if(m_uiPhase == 5)
                {
                    if (m_uiSummonVileSpiritTimer < uiDiff)
                    {
                        DoCast(me, SPELL_SUMMON_VILE_SPIRIT);
                        m_uiSummonVileSpiritTimer = 30000;
                    } else m_uiSummonVileSpiritTimer -= uiDiff;

                    if (m_uiHarvestSoulTimer < uiDiff)
                    {
                        DoScriptText(SAY_HARVEST_SOUL, me);
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            DoCast(pTarget, SPELL_HARVEST_SOULS);
                        m_uiHarvestSoulTimer = 70000;
                    } else m_uiHarvestSoulTimer -= uiDiff;
                }

                if(HealthBelowPct(71))
                {
                    if(!TransitionPhase1)
                    {
                        TransitionPhase1 = true;
                        m_uiPhase = 2; // ?????????? ?????? ????
                        Phasenswitch();
                    }
                }

                if(HealthBelowPct(41))
                {
                    if(!TransitionPhase2)
                    {
                        TransitionPhase2 = true;
                        m_uiPhase = 4;
                        Phasenswitch();
                    }
                }

                if(HealthBelowPct(12))
                {
                    if(!TriggerSpawned)
                    {
                        pSafeZone = me->SummonCreature(CREATURE_TRIGGER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_CORPSE_DESPAWN, 360000);
                        pSafeZone->AI()->AttackStart(me);
                        pSafeZone->SetDisplayId(MODEL_INVISIBLE);
                        TriggerSpawned = true;
                }   }

                if(HealthBelowPct(11))
                {
                    if(!TransitionPhase3)
                    {
                        TransitionPhase3 = true;
                        bEnding = true;
                    }
                }

                if(bEnding)
                {
                    if (m_uiEndingTimer <= uiDiff)
                    {
                        switch(m_uiEndingPhase)
                        {
                        case 1:
                            me->GetMotionMaster()->MoveIdle();
                            me->SetReactState(REACT_PASSIVE);
                            me->AttackStop();
                            me->CastStop();
                            DoResetThreat();
                            DoScriptText(SAY_10_PROZENT, me);
                            DoCastAOE(SPELL_FURY_OF_FROSTMOURNE);
                            m_uiEndingTimer = 15000;
                            ++m_uiEndingPhase;
                            break;
                        case 2:
                            DoScriptText(SAY_ENDING_1_KING, me);
                            m_uiEndingTimer = 24000;
                            ++m_uiEndingPhase;
                            break;
                        case 3:
                            DoScriptText(SAY_ENDING_2_KING, me);
                            m_uiEndingTimer = 25000;
                            ++m_uiEndingPhase;
                            break;
                        case 4:
                            me->GetMotionMaster()->MovePoint(0, MovePos[1]);
                            m_uiEndingTimer = 4000;
                            ++m_uiEndingPhase;
                            break;
                        case 5:
                            DoCastAOE(SPELL_CHANNEL_KING);
                            DoScriptText(SAY_ENDING_3_KING, me);
                            m_uiEndingTimer = 26000;
                            ++m_uiEndingPhase;
                            break;
                        case 6:
                            DoScriptText(SAY_ENDING_4_KING, me);
                            m_uiEndingTimer = 9000;
                            ++m_uiEndingPhase;
                            break;
                        case 7:
                            DoScriptText(SAY_ENDING_5_TIRION, pTirion);
                            m_uiEndingTimer = 9000;
                            ++m_uiEndingPhase;
                            break;
                        case 8:
                            DoCast(pTirion, SPELL_TIRION_LIGHT);
                            m_uiEndingTimer = 5000;
                            ++m_uiEndingPhase;
                            break;
                        case 9:
                            pTirion->RemoveAurasDueToSpell(SPELL_ICEBLOCK_TRIGGER);
                            m_uiEndingTimer = 2000;
                            ++m_uiEndingPhase;
                            break;
                        case 10:
                            pTirion->GetMotionMaster()->MovePoint(0, MovePos[2]);
                            m_uiEndingTimer = 1000;
                            ++m_uiEndingPhase;
                            break;
                        case 11:
                            pTirion->GetMotionMaster()->MoveJump(517.482910f, -2124.905762f, 1040.861328f, 10.0f, 15.0f); //pTirion->JumpTo(pFrostmourne, 15.0f);
                            pTirion->SetUInt32Value(UNIT_NPC_EMOTESTATE, 375);
                            m_uiEndingTimer = 1000;
                            ++m_uiEndingPhase;
                            break;
                        case 12:
                            me->RemoveAura(SPELL_CHANNEL_KING);
                            me->CastSpell(me, SPELL_BOOM_VISUAL, false);
                            m_uiEndingTimer = 300;
                            ++m_uiEndingPhase;
                            break;
                        case 13:
                            me->CastSpell(me, SPELL_SUMMON_BROKEN_FROSTMOURNE, false);
                            m_uiEndingTimer = 3000;
                            ++m_uiEndingPhase;
                            break;
                        case 14:
                            me->CastSpell(me, 73017, false);
                            m_uiEndingTimer = 1000;
                            ++m_uiEndingPhase;
                            break;
                        case 15:
                            DoScriptText(SAY_ENDING_6_KING, me);
                            m_uiEndingTimer = 3000;
                            ++m_uiEndingPhase;
                            break;
                        case 16:
                            pFrostmourne = me->SummonCreature(27880, me->GetPositionX()+2, me->GetPositionY()+2, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 99999999);
                            pFrostmourne->CastSpell(pFrostmourne, SPELL_BROKEN_FROSTMOURNE, false);
                            pFrostmourne->CastSpell(pFrostmourne, SPELL_FROSTMOURNE_TRIGGER, false);
                            pFrostmourne->GetMotionMaster()->MoveChase(me);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED);
                            //pTirion->CastSpell(pTirion, SPELL_DISENGAGE, false);
                            m_uiEndingTimer = 2000;
                            ++m_uiEndingPhase;
                            break;
                        case 17:
                            me->RemoveAllAuras();
                            me->RemoveAura(SPELL_SUMMON_BROKEN_FROSTMOURNE);
                            DoPlaySoundToSet(me, SOUND_ENDING_7_KING);
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 473);
                            m_uiEndingTimer = 5000;
                            ++m_uiEndingPhase;
                            break;
                        case 18:
                            DoScriptText(SAY_ENDING_8_TIRION, pTirion);
                            m_uiEndingTimer = 6000;
                            ++m_uiEndingPhase;
                            break;
                        case 19:
                            pFather = me->SummonCreature(CREAUTRE_MENETHIL, me->GetPositionX()+5, me->GetPositionY()+5, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 9999999);
                            DoScriptText(SAY_ENDING_9_FATHER, pFather);
                            PlayerRevive();
                            m_uiEndingTimer = 6000;
                            ++m_uiEndingPhase;
                            break;
                        case 20:
                            DoScriptText(SAY_ENDING_11_FATHER, pFather);
                            pFather->CastSpell(pFather, SPELL_REVIVE_VISUAL, false);
                            m_uiEndingTimer = 6000;
                            ++m_uiEndingPhase;
                            break;
                        case 21:
                            DoScriptText(SAY_ENDING_10_TIRION, pTirion);
                            m_uiEndingTimer = 5000;
                            ++m_uiEndingPhase;
                            break;
                        case 22:
                            DoScriptText(SAY_ENDING_12_KING, me);
                            //pTirion->SetReactState(REACT_AGGRESSIVE);
                            //pTirion->AI()->AttackStart(me);
                            //pFather->AI()->AttackStart(me);
                            m_uiEndingTimer = 5000;
                            ++m_uiEndingPhase;
                            break;
                        }
                    } else m_uiEndingTimer -= uiDiff;
                }

                DoMeleeAttackIfReady();
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiEndingTimer;
            uint32 m_uiEndingPhase;
            uint32 m_uiPhase;
            uint32 m_uiTirionSpawnTimer;
            uint32 m_uiSummonShamblingHorrorTimer;
            uint32 m_uiSummonDrudgeGhoulsTimer;
            uint32 m_uiSummonShadowTrap;
            uint32 m_uiInfestTimer;
            uint32 m_uiNecroticPlagueTimer;
            uint32 m_uiPlagueSiphonTimer;
            uint32 m_uiBerserkTimer;
            uint32 m_uiSummonValkyrTimer;
            uint32 m_uiSoulReaperTimer;
            uint32 m_uiDefileTimer;
            uint32 m_uiHarvestSoulTimer;
            uint32 m_uiSummonVileSpiritTimer;
            uint32 m_uiFrostGramPortTimer;
            uint32 m_uiPainandSufferingTimer;
            uint32 m_uiQuakeTimer;
            uint32 m_uiIcePulsSummonTimer;
            uint32 m_uiSummonSpiritTimer;
            uint32 m_uiRandomSpeechTimer;
            uint8 stage;

            bool TriggerSpawned;
            bool TransitionPhase1;
            bool TransitionPhase2;
            bool TransitionPhase3;
            bool bEnding;

            SummonList summons;

        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_the_lich_kingAI(pCreature);
        }
};

class npc_tirion_icc : public CreatureScript
{
    public:
        npc_tirion_icc() : CreatureScript("npc_tirion_icc") { }

        struct npc_tirion_iccAI : public ScriptedAI
        {
            npc_tirion_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
                pTirion = me;
            }

            void Reset()
            {
                m_uiIntroTimer = 1000;
                m_uiIntroPhase = 1;

                bIntro = false;

                me->SetReactState(REACT_PASSIVE);
                me->SetSpeed(MOVE_RUN, 1.8f);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            void StartEvent()
            {
                bIntro = true;
            }

            void UpdateAI(const uint32 diff)
            {
                 if(!bIntro || !pInstance)
                     return;

                if(m_uiIntroTimer <= diff)
                {
                    switch(m_uiIntroPhase)
                    {
                    case 1:
                        {
                            pInstance->SetData(DATA_THE_LICH_KING, IN_PROGRESS);
                            pLichKing->SetStandState(UNIT_STAND_STATE_STAND);
                            pLichKing->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            pLichKing->SetSpeed(MOVE_WALK, 1.2f);
                            pLichKing->GetMotionMaster()->MovePoint(0, MovePos[0]);
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 375);
                            m_uiIntroTimer = 3000;
                            ++m_uiIntroPhase;
                        }
                    break;
                    case 2:
                        pLichKing->SetUInt32Value(UNIT_NPC_EMOTESTATE, 1);
                        DoScriptText(SAY_INTRO_1_KING, pLichKing);
                        m_uiIntroTimer = 14000;
                        ++m_uiIntroPhase;
                        break;
                    case 3:
                        pLichKing->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                        DoScriptText(SAY_INTRO_2_TIRION, me);
                        m_uiIntroTimer = 9000;
                        ++m_uiIntroPhase;
                        break;
                    case 4:
                        DoScriptText(SAY_INTRO_3_KING, pLichKing);
                        pLichKing->SetUInt32Value(UNIT_NPC_EMOTESTATE, 392);
                        m_uiIntroTimer = 3000;
                        ++m_uiIntroPhase;
                        break;
                    case 5:
                        pLichKing->SetUInt32Value(UNIT_NPC_EMOTESTATE, 397);
                        m_uiIntroTimer = 2000;
                        ++m_uiIntroPhase;
                        break;
                    case 6:
                        pLichKing->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                        m_uiIntroTimer = 18000;
                        ++m_uiIntroPhase;
                        break;
                    case 7:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 397);
                        DoScriptText(SAY_INTRO_4_TIRION, me);
                        m_uiIntroTimer = 1000;
                        ++m_uiIntroPhase;
                        break;
                    case 8:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                        me->GetMotionMaster()->MovePoint(0, MovePos[3]);
                        m_uiIntroTimer = 2000;
                        ++m_uiIntroPhase;
                        break;
                    case 9:
                        me->CastSpell(me, SPELL_ICEBLOCK_TRIGGER, true);
                        m_uiIntroTimer = 2000;
                        ++m_uiIntroPhase;
                        break;
                    case 10:
                        pLichKing->SetUInt32Value(UNIT_NPC_EMOTESTATE, 1);
                        DoScriptText(SAY_INTRO_5_KING, pLichKing);
                        m_uiIntroTimer = 12000;
                        ++m_uiIntroPhase;
                        break;
                    case 11:
                        pLichKing->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                        pLichKing->SetReactState(REACT_AGGRESSIVE);
                        m_uiIntroTimer = 6000;
                        ++m_uiIntroPhase;
                        break;
                    }
                } else m_uiIntroTimer -= diff;

                if(pInstance->GetData(DATA_THE_LICH_KING) != NOT_STARTED)
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                else
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiIntroTimer;
            uint32 m_uiIntroPhase;

            bool bIntro;
        };

        bool OnGossipHello(Player* pPlayer, Creature* pCreature)
        {
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_START_EVENT, GOSSIP_SENDER_MAIN, 999999);
            pPlayer->SEND_GOSSIP_MENU(10600, pCreature->GetGUID());

            return true;
        }

        bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
        {
            if (uiAction == 999999)
            {
                CAST_AI(npc_tirion_icc::npc_tirion_iccAI, pCreature->AI())->StartEvent();
                pCreature->RemoveFlag(UNIT_NPC_FLAGS,UNIT_NPC_FLAG_GOSSIP);
                pPlayer->CLOSE_GOSSIP_MENU();
            }
            return true;
        }

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_tirion_iccAI(pCreature);
        }
};

class npc_ice_puls_icc : public CreatureScript
{
    public:
        npc_ice_puls_icc() : CreatureScript("npc_ice_puls_icc") { }

        struct npc_ice_puls_iccAI : public ScriptedAI
        {
            npc_ice_puls_iccAI(Creature* pCreature) : ScriptedAI(pCreature) { }

            void Reset()
            {
                m_uiIcePulseTimer = 3000;

                if(Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                {
                    me->AddThreat(pTarget, 500000.0f);
                    me->GetMotionMaster()->MoveChase(pTarget);
                }
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoZoneInCombat();
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiIcePulseTimer < uiDiff)
                {
                    DoCast(me->getVictim(), SPELL_ICE_PULSE);
                    m_uiIcePulseTimer = 3000;
                } else m_uiIcePulseTimer -= uiDiff;

                if (me->IsWithinDistInMap(me->getVictim(), 3))
                    DoCast(me, SPELL_ICE_BURST);
            }
        private:
            uint32 m_uiIcePulseTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_ice_puls_iccAI(pCreature);
        }
};

class npc_valkyr_icc : public CreatureScript
{
    public:
        npc_valkyr_icc() : CreatureScript("npc_valkyr_icc") { }

        struct npc_valkyr_iccAI : public ScriptedAI
        {
            npc_valkyr_iccAI(Creature* pCreature) : ScriptedAI(pCreature), vehicle(pCreature->GetVehicleKit())
            {
                assert(vehicle);
            }

            void Reset()
            {
                me->SetFlying(true);
                m_uiGrabTimer = 2000;
                m_uiMovementTimer = 3000;
                m_uiFallPlayerTimer = 10000;
                assert(vehicle);
                me->GetVehicleKit();
                InVehicle = false;
                OutVehicle = false;
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoZoneInCombat();
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiGrabTimer < uiDiff)
                {
                    if(InVehicle == false)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                        {
                            pTarget->EnterVehicle(vehicle);
                            InVehicle = true;
                            DoCast(me, SPELL_WINGS_OF_THE_DAMNED);
                            if (IsHeroic())
                                DoCast(pTarget, SPELL_LIFE_SIPHON);
                        }
                    }
                    m_uiGrabTimer = 120000;
                } else m_uiGrabTimer -= uiDiff;

                if (m_uiMovementTimer < uiDiff)
                {
                    me->GetMotionMaster()->MovePoint(0, MovePos[4]);
                    m_uiMovementTimer = 120000;
                } else m_uiMovementTimer -= uiDiff;

                if (m_uiFallPlayerTimer < uiDiff)
                {
                    if(!OutVehicle)
                    {
                        vehicle->RemoveAllPassengers();
                        OutVehicle = true;
                    }
                    m_uiFallPlayerTimer = 120000;
                } else m_uiFallPlayerTimer -= uiDiff;
            }
        private:
            uint32 m_uiGrabTimer;
            uint32 m_uiMovementTimer;
            uint32 m_uiFallPlayerTimer;

            bool InVehicle;
            bool OutVehicle;

            Vehicle* vehicle;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_valkyr_iccAI(pCreature);
        }
};

class npc_ghoul_icc : public CreatureScript
{
    public:
        npc_ghoul_icc() : CreatureScript("npc_ghoul_icc") { }

        struct npc_ghoul_iccAI : public ScriptedAI
        {
            npc_ghoul_iccAI(Creature *pCreature) : ScriptedAI(pCreature) { }

            void Reset()
            {
                m_uiLifeTimer = 1000;
                m_uiAggroTimer = 4000;

                IsLife = false;
                IsAggroTimer = false;
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoZoneInCombat();
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiLifeTimer < uiDiff && !IsLife)
                {
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 449);
                    IsLife = true;
                } else m_uiLifeTimer -= uiDiff;

                if (m_uiAggroTimer < uiDiff && !IsAggroTimer)
                {
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                    IsAggroTimer = true;
                } else m_uiAggroTimer -= uiDiff;
            }
        private:
            uint32 m_uiLifeTimer;
            uint32 m_uiAggroTimer;

            bool IsLife;
            bool IsAggroTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_ghoul_iccAI(pCreature);
        }
};

class npc_defile_icc : public CreatureScript
{
    public:
        npc_defile_icc() : CreatureScript("npc_defile_icc") { }

        struct npc_defile_iccAI : public Scripted_NoMovementAI
        {
            npc_defile_iccAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            }

            void Reset()
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                m_uiDespawnTimer = 60000;
                DoCast(me, SPELL_DEFILE);

                Despawnd = false;
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (m_uiDespawnTimer < uiDiff && !Despawnd)
                {
                    me->ForcedDespawn();
                    Despawnd = true;
                } else m_uiDespawnTimer -= uiDiff;
            }
        private:
            uint32 m_uiDespawnTimer;

            bool Despawnd;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_defile_iccAI(pCreature);
        }
};

class npc_raging_spirit_icc : public CreatureScript
{
    public:
        npc_raging_spirit_icc() : CreatureScript("npc_raging_spirit_icc") { }

        struct npc_raging_spirit_iccAI : public ScriptedAI
        {
            npc_raging_spirit_iccAI(Creature* pCreature) : ScriptedAI(pCreature) { }

            void Reset()
            {
                m_uiShriekTimer = 3000;

                DoCast(me, SPELL_RAGING_SPIRIT_VISUAL);
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoZoneInCombat();
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiShriekTimer < uiDiff)
                {
                    DoCast(me->getVictim(), SPELL_SOUL_SHRIEK);
                    m_uiShriekTimer = 3000;
                } else m_uiShriekTimer -= uiDiff;
            }
        private:
            uint32 m_uiShriekTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_raging_spirit_iccAI(pCreature);
        }
};

class npc_vile_spirit_icc : public CreatureScript
{
    public:
        npc_vile_spirit_icc() : CreatureScript("npc_vile_spirit_icc") { }

        struct npc_vile_spirit_iccAI : public ScriptedAI
        {
            npc_vile_spirit_iccAI(Creature* pCreature) : ScriptedAI(pCreature) { }

            void Reset()
            {
                m_uiMoveTimer = 15000;
                bStartMove = false;

                DoStartNoMovement(me->getVictim());

                if(Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                    me->AddThreat(pTarget, 100000.0f);
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!bStartMove && m_uiMoveTimer < uiDiff)
                {
                    DoStartMovement(me->getVictim());
                    bStartMove = true;
                    m_uiMoveTimer = 15000;
                } else m_uiMoveTimer -= uiDiff;

                if(bStartMove && me->IsWithinDistInMap(me, 2.0f, true))
                    DoCast(me->getVictim(), SPELL_BURST, true);
            }
        private:
            uint32 m_uiShriekTimer;
            bool bStartMove;
            uint32 m_uiMoveTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_vile_spirit_iccAI(pCreature);
        }
};

class npc_shambling_horror_icc : public CreatureScript
{
    public:
        npc_shambling_horror_icc() : CreatureScript("npc_shambling_horror_icc") { }

        struct npc_shambling_horror_iccAI : public ScriptedAI
        {
            npc_shambling_horror_iccAI(Creature* pCreature) : ScriptedAI(pCreature) { }

            void Reset()
            {
                m_uiEnrageTimer = 20000;
                m_uiShockTimer = 20000;
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoZoneInCombat();
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiEnrageTimer < uiDiff)
                {
                    DoCast(me, SPELL_ENRAGE);
                    m_uiEnrageTimer = 20000;
                } else m_uiEnrageTimer -= uiDiff;

                if (m_uiShockTimer < uiDiff)
                {
                    DoCast(me->getVictim(), SPELL_WHOCKVAWE);
                    m_uiShockTimer = 20000;
                } else m_uiShockTimer -= uiDiff;
            }
        private:
            uint32 m_uiEnrageTimer;
            uint32 m_uiShockTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_shambling_horror_iccAI(pCreature);
        }
};

void AddSC_boss_the_lich_king()
{
    new boss_the_lich_king();
    new npc_tirion_icc();
    new npc_ice_puls_icc();
    new npc_valkyr_icc();
    new npc_ghoul_icc();
    new npc_defile_icc();
    new npc_raging_spirit_icc();
    new npc_shambling_horror_icc();
    new npc_vile_spirit_icc();
}