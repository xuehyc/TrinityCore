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
CASTLE SQL:
UPDATE `gameobject_template` SET `data10` = 0, `ScriptName` = 'go_portal_sartharion' WHERE `entry` = 193988;
DELETE FROM `spell_script_target` WHERE `entry` IN (61254, 60430);
INSERT INTO `spell_script_target` (entry, type, targetEntry) VALUES
(61254, 1, 30449),
(61254, 1, 30451),
(61254, 1, 30452),
(60430, 1, 30643);
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Cell.h"
#include "CellImpl.h"
#include "obsidian_sanctum.h"

enum eEnums
{
    //Sartharion Yell
    SAY_SARTHARION_AGGRO                        = -1615018,
    SAY_SARTHARION_BERSERK                      = -1615019,
    SAY_SARTHARION_BREATH                       = -1615020,
    SAY_SARTHARION_CALL_SHADRON                 = -1615021,
    SAY_SARTHARION_CALL_TENEBRON                = -1615022,
    SAY_SARTHARION_CALL_VESPERON                = -1615023,
    SAY_SARTHARION_DEATH                        = -1615024,
    SAY_SARTHARION_SPECIAL_1                    = -1615025,
    SAY_SARTHARION_SPECIAL_2                    = -1615026,
    SAY_SARTHARION_SPECIAL_3                    = -1615027,
    SAY_SARTHARION_SPECIAL_4                    = -1615028,
    SAY_SARTHARION_SLAY_1                       = -1615029,
    SAY_SARTHARION_SLAY_2                       = -1615030,
    SAY_SARTHARION_SLAY_3                       = -1615031,

    WHISPER_LAVA_CHURN                          = -1615032,

    WHISPER_SHADRON_DICIPLE                     = -1615008,
    WHISPER_VESPERON_DICIPLE                    = -1615041,
    WHISPER_HATCH_EGGS                          = -1615017,
    WHISPER_OPEN_PORTAL                         = -1615042, // whisper, shared by two dragons

    //Sartharion Spells
    SPELL_BERSERK                               = 61632,    // Increases the caster's attack speed by 150% and all damage it deals by 500% for 5 min.
    SPELL_CLEAVE                                = 56909,    // Inflicts 35% weapon damage to an enemy and its nearest allies, affecting up to 10 targets.
    SPELL_FLAME_BREATH                          = 56908,    // Inflicts 8750 to 11250 Fire damage to enemies in a cone in front of the caster.
    SPELL_FLAME_BREATH_H                        = 58956,    // Inflicts 10938 to 14062 Fire damage to enemies in a cone in front of the caster.
    SPELL_TAIL_LASH                             = 56910,    // A sweeping tail strike hits all enemies behind the caster, inflicting 3063 to 3937 damage and stunning them for 2 sec.
    SPELL_TAIL_LASH_H                           = 58957,    // A sweeping tail strike hits all enemies behind the caster, inflicting 4375 to 5625 damage and stunning them for 2 sec.
    SPELL_WILL_OF_SARTHARION                    = 61254,    // Sartharion's presence bolsters the resolve of the Twilight Drakes, increasing their total health by 25%. This effect also increases Sartharion's health by 25%.
    SPELL_LAVA_STRIKE                           = 57571,    // (Real spell casted should be 57578) 57571 then trigger visual missile, then summon Lava Blaze on impact(spell 57572)
    SPELL_LAVA_STRIKE_EFFECT1                   = 57591,
    SPELL_TWILIGHT_REVENGE                      = 60639,

    SPELL_PYROBUFFET                            = 57557,    // currently used for hard enrage after 15 minutes

    // On twilight enter
    SPELL_TWILIGHT_SHIFT_ENTER                  = 57620,    // enter phase. Player get this when click GO, causes 57874
    SPELL_TWILIGHT_SHIFT                        = 57874,    // Twilight Shift Aura, caused by 57620

    // On twilight leave
    SPELL_TWILIGHT_SHIFT_REMOVAL                = 61187,    // leave phase
    SPELL_TWILIGHT_SHIFT_REMOVAL_ALL            = 61190,    // leave phase (probably version to make all leave)
    SPELL_TWILIGHT_RESIDUE                      = 61885,    // makes immune to shadow damage, applied when leave phase


    //Mini bosses common spells
    //Miniboses (Vesperon, Shadron, Tenebron)
    SPELL_SHADOW_BREATH_H                       = 59126,    // Inflicts 8788 to 10212 Fire damage to enemies in a cone in front of the caster.
    SPELL_SHADOW_BREATH                         = 57570,    // Inflicts 6938 to 8062 Fire damage to enemies in a cone in front of the caster.

    SPELL_SHADOW_FISSURE_H                      = 59127,    // Deals 9488 to 13512 Shadow damage to any enemy within the Shadow fissure after 5 sec.
    SPELL_SHADOW_FISSURE                        = 57579,    // Deals 6188 to 8812 Shadow damage to any enemy within the Shadow fissure after 5 sec.

    //Vesperon
    //In portal is a disciple, when disciple killed remove Power_of_vesperon, portal open multiple times
    NPC_ACOLYTE_OF_VESPERON                     = 31219,    // Acolyte of Vesperon
    SPELL_POWER_OF_VESPERON                     = 61251,    // Vesperon's presence decreases the maximum health of all enemies by 25%.
    SPELL_TWILIGHT_TORMENT_VESP                 = 57948,    // (Shadow only) trigger 57935 then 57988
    SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER       = 57935,    // (Shadow only) triggered by 57948, triggers then 57988
    SPELL_TWILIGHT_TORMENT_VESP_ACO_ON_PLAYER   = 58835,    // (Fire and Shadow) trigger 58835 then 57988

    //Shadron
    //In portal is a disciple, when disciple killed remove Power_of_vesperon, portal open multiple times
    NPC_ACOLYTE_OF_SHADRON                      = 31218,    // Acolyte of Shadron
    SPELL_POWER_OF_SHADRON                      = 58105,    // Shadron's presence increases Fire damage taken by all enemies by 100%.
    SPELL_GIFT_OF_TWILIGTH_SHA                  = 57835,    // TARGET_SCRIPT shadron
    SPELL_GIFT_OF_TWILIGTH_SAR                  = 58766,    // TARGET_SCRIPT sartharion
    SPELL_VOID_BLAST                            = 57581,    // Twilight Fissure
    SPELL_VOID_BLAST_H                          = 59128,

    //Tenebron
    //in the portal spawns 6 eggs, if not killed in time (approx. 20s)  they will hatch,  whelps can cast 60708
    SPELL_POWER_OF_TENEBRON                     = 61248,    // Tenebron's presence increases Shadow damage taken by all enemies by 100%.
    NPC_TWILIGHT_EGG                            = 30882,

    //Whelps
    NPC_TWILIGHT_WHELP                          = 30890,
    SPELL_FADE_ARMOR                            = 60708,    // Reduces the armor of an enemy by 1500 for 15s

    //flame tsunami
    SPELL_FLAME_TSUNAMI                         = 57494,    // the visual dummy

    SPELL_FLAME_TSUNAMI_DMG_AURA                = 57491,    // periodic damage, npc has this aura
    SPELL_FLAME_TSUNAMI_BUFF                    = 60430,

    NPC_FLAME_TSUNAMI                           = 30616,    // for the flame waves
    NPC_LAVA_BLAZE                              = 30643,    // adds spawning from flame strike

    //using these custom points for dragons start and end
    POINT_ID_INIT                               = 100,
    POINT_ID_LAND                               = 200,

    // Achievements
    ACHIEV_VULCAN                               = 2047, // 7326
    H_ACHIEV_VULCAN                             = 2048 // 7327
};

//each dragons special points. First where fly to before connect to connon, second where land point is.
const Position m_aTene[]=
{
    {3212.854f, 575.597f, 109.856f, 0.0f},                           //init
    {3246.425f, 565.367f, 61.249f, 0.0f}                             //end
};

const Position m_aShad[]=
{
    {3293.238f, 472.223f, 106.968f, 0.0f},
    {3271.669f, 526.907f, 61.931f, 0.0f}
};

const Position m_aVesp[]=
{
    {3193.310f, 472.861f, 102.697f, 0.0f},
    {3227.268f, 533.238f, 59.995f, 0.0f}
};

#define MAX_WAYPOINT 6
//points around raid "isle", counter clockwise. should probably be adjusted to be more alike
const Position m_aDragonCommon[MAX_WAYPOINT]=
{
    {3214.012f, 468.932f, 98.652f, 0.0f},
    {3244.950f, 468.427f, 98.652f, 0.0f},
    {3283.520f, 496.869f, 98.652f, 0.0f},
    {3287.316f, 555.875f, 98.652f, 0.0f},
    {3250.479f, 585.827f, 98.652f, 0.0f},
    {3209.969f, 566.523f, 98.652f, 0.0f}
};

const Position FlameRight1Spawn = { 3200.00f, 573.211f, 57.1551f, 0.0f };
const Position FlameRight1Direction = { 3289.28f, 573.211f, 57.1551f, 0.0f };
const Position FlameRight2Spawn = { 3200.00f, 532.211f, 57.1551f, 0.0f };
const Position FlameRight2Direction = { 3289.28f, 532.211f, 57.1551f, 0.0f };
const Position FlameRight3Spawn = { 3200.00f, 491.211f, 57.1551f, 0.0f };
const Position FlameRight3Direction = { 3289.28f, 491.211f, 57.1551f, 0.0f };
const Position FlameLeft1Spawn = { 3289.28f, 511.711f, 57.1551f, 0.0f };
const Position FlameLeft1Direction = { 3200.00f, 511.711f, 57.1551f, 0.0f };
const Position FlameLeft2Spawn = { 3289.28f, 552.711f, 57.1551f, 0.0f };
const Position FlameLeft2Direction = { 3200.00f, 552.711f, 57.1551f, 0.0f };

#define TWILIGHT_ACHIEVEMENTS     1

void HandleAuraOnRaidSartharion(Unit* caller, uint32 spellId, bool remove, bool add, uint32 addAmount, bool onlyInTwilight, bool onlyInRealWorld)
{
    if (spellId <= 0 || (add && addAmount <= 0) || !caller)
        return;

    Map* map = caller->GetMap();
    if (map && map->IsDungeon())
    {
        Map::PlayerList const &PlayerList = map->GetPlayers();

        if (PlayerList.isEmpty())
            return;

        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        {
            if (i->getSource())
            {
                if (i->getSource()->isAlive())
                {
                    if (onlyInTwilight)
                    {
                        if (!i->getSource()->HasAura(SPELL_TWILIGHT_SHIFT_ENTER))
                            continue;
                    }

                    if (onlyInRealWorld)
                    {
                        if (i->getSource()->HasAura(SPELL_TWILIGHT_SHIFT_ENTER))
                            continue;
                    }

                    if (remove)
                        if (i->getSource()->HasAura(spellId))
                            i->getSource()->RemoveAurasDueToSpell(spellId);

                    if (add)
                    {
                        if (addAmount > 0)
                        {
                            if (Aura* aur = caller->AddAura(spellId, i->getSource()))
                            {
                                aur->SetStackAmount(addAmount);
                                aur->SetCharges(addAmount);
                            }
                        }
                    }
                }
            }
       }
    }
}

/*######
## Boss Sartharion
######*/

class boss_sartharion : public CreatureScript
{
public:
    boss_sartharion() : CreatureScript("boss_sartharion") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_sartharionAI(creature);
    }

    struct boss_sartharionAI : public ScriptedAI
    {
        boss_sartharionAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        bool m_bIsBerserk;
        bool m_bIsSoftEnraged;

        uint32 m_uiEnrageTimer;

        uint32 m_uiTenebronTimer;
        uint32 m_uiShadronTimer;
        uint32 m_uiVesperonTimer;

        uint32 m_uiFlameTsunamiTimer;
        uint32 m_uiFlameBreathTimer;
        uint32 m_uiTailSweepTimer;
        uint32 m_uiCleaveTimer;
        uint32 m_uiLavaStrikeTimer;

        bool m_bHasCalledTenebron;
        bool m_bHasCalledShadron;
        bool m_bHasCalledVesperon;

        uint8 drakeCount;

        uint32 m_uiCheckPlayerTimer;
        bool hasSoftEnraged;

        std::set<uint64> playersHitByLavaStrike;

        void Reset()
        {
            m_bIsBerserk = false;
            m_bIsSoftEnraged = false;
            hasSoftEnraged = false;

            m_uiEnrageTimer = 15*MINUTE*IN_MILLISECONDS;

            m_uiTenebronTimer = 30000;
            m_uiShadronTimer = 75000;
            m_uiVesperonTimer = 120000;

            m_uiFlameTsunamiTimer = 30000;
            m_uiFlameBreathTimer = 20000;
            m_uiTailSweepTimer = 20000;
            m_uiCleaveTimer = 7000;

            m_bHasCalledTenebron = false;
            m_bHasCalledShadron = false;
            m_bHasCalledVesperon = false;

            m_uiLavaStrikeTimer = 15000;
            m_uiCheckPlayerTimer = 2000;

            playersHitByLavaStrike.clear();

            if (me->HasAura(SPELL_TWILIGHT_REVENGE))
                me->RemoveAurasDueToSpell(SPELL_TWILIGHT_REVENGE);

            me->ResetLootMode();
            me->SetHomePosition(3246.57f, 551.263f, 58.6164f, 4.66003f);

            drakeCount = 0;

            // Drakes respawning system
            if (instance)
            {
                Creature* pTenebron = Unit::GetCreature(*me, instance->GetData64(DATA_TENEBRON));
                Creature* pShadron = Unit::GetCreature(*me, instance->GetData64(DATA_SHADRON));
                Creature* pVesperon = Unit::GetCreature(*me, instance->GetData64(DATA_VESPERON));
                if (pTenebron)
                {
                    pTenebron->SetHomePosition(3239.07f, 657.235f, 86.8775f, 4.74729f);
                    if (pTenebron->isAlive())
                    {
                        if (pTenebron->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                            pTenebron->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                        pTenebron->Relocate(3239.07f, 657.235f, 86.8775f, 4.74729f);
                        pTenebron->MonsterMoveWithSpeed(3239.07f, 657.235f, 86.8775f, 0);

                        if (pTenebron->AI())
                            pTenebron->AI()->EnterEvadeMode();
                    }else
                    {
                        if (instance->GetData(TYPE_TENEBRON_PREKILLED) != DONE)
                        {
                            pTenebron->Respawn(true);
                            pTenebron->setActive(true);

                            pTenebron->Relocate(3239.07f, 657.235f, 86.8775f, 4.74729f);
                            pTenebron->MonsterMoveWithSpeed(3239.07f, 657.235f, 86.8775f, 0);

                            if (pTenebron->AI())
                                pTenebron->AI()->EnterEvadeMode();
                        }
                    }
                }
                if (pShadron)
                {
                    pShadron->SetHomePosition(3363.06f, 525.28f, 98.362f, 4.76475f);
                    if (pShadron->isAlive())
                    {
                        if (pShadron->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                            pShadron->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                        pShadron->Relocate(3363.06f, 525.28f, 98.362f, 4.76475f);
                        pShadron->MonsterMoveWithSpeed(3363.06f, 525.28f, 98.362f, 0);

                        if (pShadron->AI())
                            pShadron->AI()->EnterEvadeMode();
                    }else
                    {
                        if (instance->GetData(TYPE_SHADRON_PREKILLED) != DONE)
                        {
                            pShadron->Respawn(true);
                            pShadron->setActive(true);

                            pShadron->Relocate(3363.06f, 525.28f, 98.362f, 4.76475f);
                            pShadron->MonsterMoveWithSpeed(3363.06f, 525.28f, 98.362f, 0);

                            if (pShadron->AI())
                                pShadron->AI()->EnterEvadeMode();
                        }
                    }
                }
                if (pVesperon)
                {
                    pVesperon->SetHomePosition(3145.68f, 520.71f, 89.7f, 4.64258f);
                    if (pVesperon->isAlive())
                    {
                        if (pVesperon->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                            pVesperon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                        pVesperon->Relocate(3145.68f, 520.71f, 89.7f, 4.64258f);
                        pVesperon->MonsterMoveWithSpeed(3145.68f, 520.71f, 89.7f, 0);

                        if (pVesperon->AI())
                            pVesperon->AI()->EnterEvadeMode();
                    }else
                    {
                        if (instance->GetData(TYPE_VESPERON_PREKILLED) != DONE)
                        {
                            pVesperon->Respawn(true);
                            pVesperon->setActive(true);

                            pVesperon->Relocate(3145.68f, 520.71f, 89.7f, 4.64258f);
                            pVesperon->MonsterMoveWithSpeed(3145.68f, 520.71f, 89.7f, 0);

                            if (pVesperon->AI())
                                pVesperon->AI()->EnterEvadeMode();
                        }
                    }
                }
            }
        }

        void JustReachedHome()
        {
            if (instance)
                instance->SetData(TYPE_SARTHARION_EVENT, NOT_STARTED);
        }

        void JustSummoned(Creature* summon)
        {
            if (summon->GetEntry() == NPC_LAVA_BLAZE)
                DoZoneInCombat(summon);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_SARTHARION_AGGRO, me);
            DoZoneInCombat();

            if (instance)
            {
                instance->SetData(TYPE_SARTHARION_EVENT, IN_PROGRESS);
                FetchDragons();
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_SARTHARION_DEATH, me);

            if (instance)
            {
                Creature* pTenebron = Unit::GetCreature(*me, instance->GetData64(DATA_TENEBRON));
                Creature* pShadron = Unit::GetCreature(*me, instance->GetData64(DATA_SHADRON));
                Creature* pVesperon = Unit::GetCreature(*me, instance->GetData64(DATA_VESPERON));
                if (pTenebron && pTenebron->isAlive())
                    pTenebron->DisappearAndDie();
                if (pShadron && pShadron->isAlive())
                    pShadron->DisappearAndDie();
                if (pVesperon && pVesperon->isAlive())
                    pVesperon->DisappearAndDie();

                instance->SetData(TYPE_SARTHARION_EVENT, DONE);
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_SARTHARION_SLAY_1, SAY_SARTHARION_SLAY_2, SAY_SARTHARION_SLAY_3), me);
        }

        // me->ResetLootMode() is called from Reset()
        // AddDrakeLootMode() should only ever be called from FetchDragons(), which is called from Aggro()
        void AddDrakeLootMode()
        {
            if (me->HasLootMode(LOOT_MODE_HARD_MODE_2))      // Has two Drake loot modes
                me->AddLootMode(LOOT_MODE_HARD_MODE_3);      // Add 3rd Drake loot mode
            else if (me->HasLootMode(LOOT_MODE_HARD_MODE_1)) // Has one Drake loot mode
                me->AddLootMode(LOOT_MODE_HARD_MODE_2);      // Add 2nd Drake loot mode
            else                                             // Has no Drake loot modes
                me->AddLootMode(LOOT_MODE_HARD_MODE_1);      // Add 1st Drake loot mode
        }

        uint32 GetData(uint32 type)
        {
            if (type == TWILIGHT_ACHIEVEMENTS)
                return drakeCount;

            return 0;
        }

        void FetchDragons()
        {
            if (!instance)
                return;

            me->ResetLootMode();
            drakeCount = 0;

            Creature* pFetchTene = Unit::GetCreature(*me, instance->GetData64(DATA_TENEBRON));
            Creature* pFetchShad = Unit::GetCreature(*me, instance->GetData64(DATA_SHADRON));
            Creature* pFetchVesp = Unit::GetCreature(*me, instance->GetData64(DATA_VESPERON));

            //if at least one of the dragons are alive and are being called
            bool bCanUseWill = false;

            if (pFetchTene && pFetchTene->isAlive() && !pFetchTene->getVictim())
            {
                bCanUseWill = true;
                if (!pFetchTene->isInCombat())
                {
                    AddDrakeLootMode();
                    ++drakeCount;
                }
                pFetchTene->RemoveLootMode(1);

                if (pFetchTene->GetMotionMaster())
                    pFetchTene->GetMotionMaster()->MovePoint(POINT_ID_INIT, m_aTene[0].GetPositionX(), m_aTene[0].GetPositionY(), m_aTene[0].GetPositionZ());

                if (!pFetchTene->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    pFetchTene->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            if (pFetchShad && pFetchShad->isAlive() && !pFetchShad->getVictim())
            {
                bCanUseWill = true;
                if (!pFetchShad->isInCombat())
                {
                    AddDrakeLootMode();
                    ++drakeCount;
                }
                pFetchShad->RemoveLootMode(1);

                if (pFetchShad->GetMotionMaster())
                    pFetchShad->GetMotionMaster()->MovePoint(POINT_ID_INIT, m_aShad[0].GetPositionX(), m_aShad[0].GetPositionY(), m_aShad[0].GetPositionZ());

                if (!pFetchShad->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    pFetchShad->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            if (pFetchVesp && pFetchVesp->isAlive() && !pFetchVesp->getVictim())
            {
                bCanUseWill = true;
                if (!pFetchVesp->isInCombat())
                {
                    AddDrakeLootMode();
                    ++drakeCount;
                }
                pFetchVesp->RemoveLootMode(1);

                if (pFetchVesp->GetMotionMaster())
                    pFetchVesp->GetMotionMaster()->MovePoint(POINT_ID_INIT, m_aVesp[0].GetPositionX(), m_aVesp[0].GetPositionY(), m_aVesp[0].GetPositionZ());

                if (!pFetchVesp->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    pFetchVesp->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            if (bCanUseWill)
                DoCast(me, SPELL_WILL_OF_SARTHARION, true);
        }

        void CheckPlayerPositions(Unit* who)
        {
            if (!who)
                return;

            if (who->IsInWater() && who->isAlive())
            {
                if (who->GetTypeId() == TYPEID_PLAYER)
                {
                    who->ToPlayer()->TeleportTo(615, 3246.5f, 530.4f, 59.5f, 1.5f);
                }
                else
                {
                    who->Relocate(3246.5f, 530.4f, 59.5f, 1.5f);
                    who->MonsterMoveWithSpeed(3246.5f, 530.4f, 59.5f, 0);
                }
            }

            Map* map = me->GetMap();
            if (map && map->IsDungeon())
            {
                Map::PlayerList const &PlayerList = map->GetPlayers();

                if (PlayerList.isEmpty())
                    return;

                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                {
                    if (i->getSource())
                    {
                        if (i->getSource()->isAlive() && !i->getSource()->HasAura(SPELL_FLAME_TSUNAMI_DMG_AURA))
                        {
                            if (i->getSource()->GetPositionX() < 3182.0f ||
                                i->getSource()->GetPositionX() > 3318.0f ||
                                i->getSource()->GetPositionY() > 617.0f ||
                                i->getSource()->GetPositionY() < 483.0f ||
                                (i->getSource()->GetPositionX() < 3230.3f && i->getSource()->GetPositionY() > 565.8f) ||
                                (i->getSource()->GetPositionX() > 3233.7f && i->getSource()->GetPositionY() < 492.0f) ||
                                i->getSource()->GetPositionZ() < 12.0f ||
                                i->getSource()->GetPositionZ() > 170.0f)
                            {
                                i->getSource()->TeleportTo(615, 3246.5f, 530.4f, 59.5f, 1.5f);
                            }
                        }
                    }
               }
            }
        }

        void CallDragon(uint32 uiDataId)
        {
            if (instance)
            {
                if (Creature* temp = Unit::GetCreature(*me, instance->GetData64(uiDataId)))
                {
                    if (temp->isAlive() && !temp->getVictim())
                    {
                        if (temp->HasUnitMovementFlag(MOVEMENTFLAG_WALKING))
                            temp->SetWalk(false);

                        if (temp->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                            temp->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                        DoCast(me, SPELL_WILL_OF_SARTHARION, true);

                        int32 iTextId = 0;

                        switch (temp->GetEntry())
                        {
                            case NPC_TENEBRON:
                                iTextId = SAY_SARTHARION_CALL_TENEBRON;

                                if (!temp->HasAura(SPELL_POWER_OF_TENEBRON))
                                    temp->AddAura(SPELL_POWER_OF_TENEBRON, temp);

                                if (temp->GetMotionMaster())
                                    temp->GetMotionMaster()->MovePoint(POINT_ID_LAND, m_aTene[1].GetPositionX(), m_aTene[1].GetPositionY(), m_aTene[1].GetPositionZ());

                                break;
                            case NPC_SHADRON:
                                iTextId = SAY_SARTHARION_CALL_SHADRON;

                                if (!temp->HasAura(SPELL_POWER_OF_SHADRON))
                                    temp->AddAura(SPELL_POWER_OF_SHADRON, temp);

                                if (temp->GetMotionMaster())
                                    temp->GetMotionMaster()->MovePoint(POINT_ID_LAND, m_aShad[1].GetPositionX(), m_aShad[1].GetPositionY(), m_aShad[1].GetPositionZ());

                                break;
                            case NPC_VESPERON:
                                iTextId = SAY_SARTHARION_CALL_VESPERON;

                                if (!temp->HasAura(SPELL_POWER_OF_VESPERON))
                                    temp->AddAura(SPELL_POWER_OF_VESPERON, temp);

                                if (temp->GetMotionMaster())
                                    temp->GetMotionMaster()->MovePoint(POINT_ID_LAND, m_aVesp[1].GetPositionX(), m_aVesp[1].GetPositionY(), m_aVesp[1].GetPositionZ());

                                break;
                        }

                        DoScriptText(iTextId, me);
                    }
                }
            }
        }

        void SendFlameTsunami()
        {
            if (Map* map = me->GetMap())
                if (map->IsDungeon())
                {
                    Map::PlayerList const &PlayerList = map->GetPlayers();

                    if (!PlayerList.isEmpty())
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            if (i->getSource() && i->getSource()->isAlive())
                                DoScriptText(WHISPER_LAVA_CHURN, me, i->getSource());
                }
        }

        void SpellHitTarget(Unit* who, SpellInfo const* spell)
        {
            if (who && who->GetTypeId() == TYPEID_PLAYER && spell->Id == SPELL_LAVA_STRIKE_EFFECT1)
                playersHitByLavaStrike.insert(who->GetGUID());
        }

        bool wasPlayerHitByLavaStrike(uint64 guid)
        {
            return playersHitByLavaStrike.count(guid) == 0;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            Unit* pTene = Unit::GetUnit(*me, instance ? instance->GetData64(DATA_TENEBRON) : 0);
            Unit* pShad = Unit::GetUnit(*me, instance ? instance->GetData64(DATA_SHADRON) : 0);
            Unit* pVesp = Unit::GetUnit(*me, instance ? instance->GetData64(DATA_VESPERON) : 0);

            //spell will target dragons, if they are still alive at 35%
            if (!m_bIsBerserk && !HealthAbovePct(35))
            {
                bool oneDrakeAlive = false;

                if (pTene)
                {
                    if (pTene->isAlive())
                    {
                        pTene->AddAura(SPELL_BERSERK, pTene);
                        oneDrakeAlive = true;
                    }
                }

                if (pShad)
                {
                    if (pShad->isAlive())
                    {
                        pShad->AddAura(SPELL_BERSERK, pShad);
                        oneDrakeAlive = true;
                    }
                }

                if (pVesp)
                {
                    if (pVesp->isAlive())
                    {
                        pVesp->AddAura(SPELL_BERSERK, pVesp);
                        oneDrakeAlive = true;
                    }
                }

                if (oneDrakeAlive)
                {
                    DoScriptText(SAY_SARTHARION_BERSERK, me);
                    me->AddAura(SPELL_BERSERK, me);
                }

                m_bIsBerserk = true;
            }

            if (m_uiEnrageTimer <= uiDiff)
            {
                DoCast(me, SPELL_PYROBUFFET, true);
                m_uiEnrageTimer = 500;
            }
            else
                m_uiEnrageTimer -= uiDiff;

            if (!m_bIsSoftEnraged && HealthBelowPct(10) && !hasSoftEnraged)
            {
                m_bIsSoftEnraged = true;
                m_uiLavaStrikeTimer = 1000;
            }

            // Lavas Strike
            if (m_uiLavaStrikeTimer <= uiDiff)
            {
                if (m_bIsSoftEnraged && !hasSoftEnraged)
                {
                    hasSoftEnraged = true;

                    for (uint8 i = 0; i < 9; i++)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        {
                            me->CastSpell(target, SPELL_LAVA_STRIKE, true);
                        }
                    }
                }
                else if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                {
                    me->CastSpell(target, SPELL_LAVA_STRIKE, true);
                }

                if (urand(0, 5) == 0)
                    DoScriptText(RAND(SAY_SARTHARION_SPECIAL_1, SAY_SARTHARION_SPECIAL_2, SAY_SARTHARION_SPECIAL_3), me);

                m_uiLavaStrikeTimer = urand(5000, 20000);
            }
            else
                m_uiLavaStrikeTimer -= uiDiff;

            // flame tsunami
            if (m_uiFlameTsunamiTimer <= uiDiff)
            {
                SendFlameTsunami();
                switch (urand(0, 1))
                {
                    case 0:
                    {
                        Creature* Right1 = me->SummonCreature(NPC_FLAME_TSUNAMI, FlameRight1Spawn.GetPositionX(), FlameRight1Spawn.GetPositionY(), FlameRight1Spawn.GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 12000);
                        Creature* Right2 = me->SummonCreature(NPC_FLAME_TSUNAMI, FlameRight2Spawn.GetPositionX(), FlameRight2Spawn.GetPositionY(), FlameRight2Spawn.GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 12000);
                        Creature* Right3 = me->SummonCreature(NPC_FLAME_TSUNAMI, FlameRight3Spawn.GetPositionX(), FlameRight3Spawn.GetPositionY(), FlameRight3Spawn.GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 12000);

                        if (Right1 && Right2 && Right3)
                        {
                            if (Right1->GetMotionMaster() && Right2->GetMotionMaster() && Right3->GetMotionMaster())
                            {
                                if (Right1->AI() && Right2->AI() && Right3->AI())
                                {
                                    Right1->SetSpeed(MOVE_SWIM, 1.6f);
                                    Right2->SetSpeed(MOVE_SWIM, 1.6f);
                                    Right3->SetSpeed(MOVE_SWIM, 1.6f);
                                    Right1->GetMotionMaster()->MovePoint(1, FlameRight1Direction.GetPositionX(), FlameRight1Direction.GetPositionY(), FlameRight1Direction.GetPositionZ());
                                    Right2->GetMotionMaster()->MovePoint(1, FlameRight2Direction.GetPositionX(), FlameRight2Direction.GetPositionY(), FlameRight2Direction.GetPositionZ());
                                    Right3->GetMotionMaster()->MovePoint(1, FlameRight3Direction.GetPositionX(), FlameRight3Direction.GetPositionY(), FlameRight3Direction.GetPositionZ());
                                    Right1->AI()->SetData(1, 1);
                                    Right2->AI()->SetData(1, 1);
                                    Right3->AI()->SetData(1, 1);
                                }
                            }
                        }

                        break;
                    }
                    case 1:
                    {
                        Creature* Left1 = me->SummonCreature(NPC_FLAME_TSUNAMI, FlameLeft1Spawn.GetPositionX(), FlameLeft1Spawn.GetPositionY(), FlameLeft1Spawn.GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 12000);
                        Creature* Left2 = me->SummonCreature(NPC_FLAME_TSUNAMI, FlameLeft2Spawn.GetPositionX(), FlameLeft2Spawn.GetPositionY(), FlameLeft2Spawn.GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 12000);

                        if (Left1 && Left2)
                        {
                            if (Left1->GetMotionMaster() && Left2->GetMotionMaster())
                            {
                                if (Left1->AI() && Left2->AI())
                                {
                                    Left1->SetSpeed(MOVE_SWIM, 1.6f);
                                    Left2->SetSpeed(MOVE_SWIM, 1.6f);
                                    Left1->GetMotionMaster()->MovePoint(2, FlameLeft1Direction.GetPositionX(), FlameLeft1Direction.GetPositionY(), FlameLeft1Direction.GetPositionZ());
                                    Left2->GetMotionMaster()->MovePoint(2, FlameLeft2Direction.GetPositionX(), FlameLeft2Direction.GetPositionY(), FlameLeft2Direction.GetPositionZ());
                                    Left1->AI()->SetData(1, 2);
                                    Left2->AI()->SetData(1, 2);
                                }
                            }
                        }

                        break;
                    }
                }

                m_uiFlameTsunamiTimer = 30000;
            }
            else
                m_uiFlameTsunamiTimer -= uiDiff;

            // check players
            if (m_uiCheckPlayerTimer <= uiDiff)
            {
                CheckPlayerPositions(me->getVictim());
                m_uiCheckPlayerTimer = 1000;
            }
            else
                m_uiCheckPlayerTimer -= uiDiff;

            // flame breath
            if (m_uiFlameBreathTimer <= uiDiff)
            {
                DoScriptText(SAY_SARTHARION_BREATH, me);
                DoCast(me->getVictim(), RAID_MODE(SPELL_FLAME_BREATH, SPELL_FLAME_BREATH_H));
                m_uiFlameBreathTimer = urand(25000, 35000);
            }
            else
                m_uiFlameBreathTimer -= uiDiff;

            // Tail Sweep
            if (m_uiTailSweepTimer <= uiDiff)
            {
                DoCast(me->getVictim(), RAID_MODE(SPELL_TAIL_LASH, SPELL_TAIL_LASH_H));
                m_uiTailSweepTimer = urand(15000, 20000);
            }
            else
                m_uiTailSweepTimer -= uiDiff;

            // Cleave
            if (m_uiCleaveTimer <= uiDiff)
            {
                DoCast(me->getVictim(), SPELL_CLEAVE);
                m_uiCleaveTimer = urand(7000, 10000);
            }
            else
                m_uiCleaveTimer -= uiDiff;

            // call tenebron
            if (!m_bHasCalledTenebron && m_uiTenebronTimer <= uiDiff)
            {
                CallDragon(DATA_TENEBRON);
                m_bHasCalledTenebron = true;
            }
            else
                m_uiTenebronTimer -= uiDiff;

            // call shadron
            if (!m_bHasCalledShadron && m_uiShadronTimer <= uiDiff)
            {
                CallDragon(DATA_SHADRON);
                m_bHasCalledShadron = true;
            }
            else
                m_uiShadronTimer -= uiDiff;

            // call vesperon
            if (!m_bHasCalledVesperon && m_uiVesperonTimer <= uiDiff)
            {
                CallDragon(DATA_VESPERON);
                m_bHasCalledVesperon = true;
            }
            else
                m_uiVesperonTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

enum TeneText
{
    SAY_TENEBRON_AGGRO                      = -1615009,
    SAY_TENEBRON_SLAY_1                     = -1615010,
    SAY_TENEBRON_SLAY_2                     = -1615011,
    SAY_TENEBRON_DEATH                      = -1615012,
    SAY_TENEBRON_BREATH                     = -1615013,
    SAY_TENEBRON_RESPOND                    = -1615014,
    SAY_TENEBRON_SPECIAL_1                  = -1615015,
    SAY_TENEBRON_SPECIAL_2                  = -1615016
};

enum ShadText
{
    SAY_SHADRON_AGGRO                       = -1615000,
    SAY_SHADRON_SLAY_1                      = -1615001,
    SAY_SHADRON_SLAY_2                      = -1615002,
    SAY_SHADRON_DEATH                       = -1615003,
    SAY_SHADRON_BREATH                      = -1615004,
    SAY_SHADRON_RESPOND                     = -1615005,
    SAY_SHADRON_SPECIAL_1                   = -1615006,
    SAY_SHADRON_SPECIAL_2                   = -1615007
};

enum VespText
{
    SAY_VESPERON_AGGRO                      = -1615033,
    SAY_VESPERON_SLAY_1                     = -1615034,
    SAY_VESPERON_SLAY_2                     = -1615035,
    SAY_VESPERON_DEATH                      = -1615036,
    SAY_VESPERON_BREATH                     = -1615037,
    SAY_VESPERON_RESPOND                    = -1615038,
    SAY_VESPERON_SPECIAL_1                  = -1615039,
    SAY_VESPERON_SPECIAL_2                  = -1615040
};

//to control each dragons common abilities
struct dummy_dragonAI : public ScriptedAI
{
    dummy_dragonAI(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;

    uint32 m_uiWaypointId;
    uint32 m_uiMoveNextTimer;
    bool m_bCanMoveFree;

    void Reset()
    {
        if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

        m_uiWaypointId = 0;
        m_uiMoveNextTimer = 500;
        m_bCanMoveFree = false;
    }

    void MovementInform(uint32 uiType, uint32 uiPointId)
    {
        if (!instance || uiType != POINT_MOTION_TYPE)
            return;

//        debug_log("dummy_dragonAI: %s reached point %u", me->GetName(), uiPointId);

        //if healers messed up the raid and we was already initialized
        if (instance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
        {
            EnterEvadeMode();
            return;
        }

        //this is end, if we reach this, don't do much
        if (uiPointId == POINT_ID_LAND)
        {
            if (me->GetMotionMaster())
                me->GetMotionMaster()->Clear();

            DoZoneInCombat();

            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0, true))
            {
                me->AddThreat(target, 1.0f);
                me->Attack(target, true);

                if (me->GetMotionMaster())
                    me->GetMotionMaster()->MoveChase(target);
            }

            m_bCanMoveFree = false;
            return;
        }

        //get amount of common points
        uint32 uiCommonWPCount = sizeof(m_aDragonCommon)/sizeof(Position);

        //increase
        m_uiWaypointId = uiPointId+1;

        //if we have reached a point bigger or equal to count, it mean we must reset to point 0
        if (m_uiWaypointId >= uiCommonWPCount)
        {
            if (!m_bCanMoveFree)
                m_bCanMoveFree = true;

            m_uiWaypointId = 0;
        }

        m_uiMoveNextTimer = 500;
    }

    //used when open portal and spawn mobs in phase
    void DoRaidWhisper(int32 iTextId)
    {
        Map* map = me->GetMap();

        if (map && map->IsDungeon())
        {
            Map::PlayerList const &PlayerList = map->GetPlayers();

            if (!PlayerList.isEmpty())
            {
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    DoScriptText(iTextId, me, i->getSource());
            }
        }
    }

    //"opens" the portal and does the "opening" whisper
    void OpenPortal()
    {
        int32 iTextId = 0;

        Position spawnPos;

        switch (me->GetEntry())
        {
            case NPC_TENEBRON:
            {
                iTextId = WHISPER_HATCH_EGGS;

                for(uint32 i = 0; i < 6; ++i)
                {
                    me->GetRandomNearPosition(spawnPos, 10.0f);
                    me->SummonCreature(NPC_TWILIGHT_EGG, spawnPos, TEMPSUMMON_CORPSE_DESPAWN);
                }

                break;
            }
            case NPC_SHADRON:
            {
                iTextId = WHISPER_OPEN_PORTAL;

                me->GetRandomNearPosition(spawnPos, 10.0f);
                me->SummonCreature(NPC_ACOLYTE_OF_SHADRON, spawnPos, TEMPSUMMON_CORPSE_DESPAWN);

                break;
            }
            case NPC_VESPERON:
            {
                iTextId = WHISPER_OPEN_PORTAL;

                me->GetRandomNearPosition(spawnPos, 10.0f);
                me->SummonCreature(NPC_ACOLYTE_OF_VESPERON, spawnPos, TEMPSUMMON_CORPSE_DESPAWN);

                break;
            }
        }

        DoRaidWhisper(iTextId);

        if (!me->FindNearestGameObject(GO_TWILIGHT_PORTAL, 65.0f))
        {
            if (instance)
            {
                if (instance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
                {
                    if (GameObject* pPortal = me->SummonGameObject(GO_TWILIGHT_PORTAL, 3234.3f, 544.7f, 58.7f, me->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 86400000))
                    {
                        me->RemoveGameObject(pPortal, false);
                        pPortal->SetSpawnedByDefault(false);
                        pPortal->SetPhaseMask(17, true);
                    }
                }
                else if (GameObject* pPortal = me->SummonGameObject(GO_TWILIGHT_PORTAL, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), 0, 0, 0, 0, 86400000))
                {
                    me->RemoveGameObject(pPortal, false);
                    pPortal->SetSpawnedByDefault(false);
                    pPortal->SetPhaseMask(17, true);
                }
            }
        }
    }

    void JustDied(Unit* /*killer*/)
    {
        int32 iTextId = 0;
        uint32 uiSpellId = 0;

        switch (me->GetEntry())
        {
            case NPC_TENEBRON:
                iTextId = SAY_TENEBRON_DEATH;
                uiSpellId = SPELL_POWER_OF_TENEBRON;

                if (instance)
                    if (instance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
                        instance->SetData(TYPE_TENEBRON_PREKILLED, DONE);

                break;
            case NPC_SHADRON:
                iTextId = SAY_SHADRON_DEATH;
                uiSpellId = SPELL_POWER_OF_SHADRON;
                if (instance)
                    if (instance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
                        instance->SetData(TYPE_SHADRON_PREKILLED, DONE);

                if (Creature* pAcolyte = me->FindNearestCreature(NPC_ACOLYTE_OF_SHADRON, 100.0f))
                    pAcolyte->Kill(pAcolyte);
                break;
            case NPC_VESPERON:
                iTextId = SAY_VESPERON_DEATH;
                uiSpellId = SPELL_POWER_OF_VESPERON;

                if (instance)
                    if (instance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
                        instance->SetData(TYPE_VESPERON_PREKILLED, DONE);

                if (Creature* pAcolyte = me->FindNearestCreature(NPC_ACOLYTE_OF_VESPERON, 100.0f))
                    pAcolyte->Kill(pAcolyte);
                break;
        }

        DoScriptText(iTextId, me);

        me->RemoveAurasDueToSpell(uiSpellId);

        if (instance)
        {
            instance->DoRemoveAurasDueToSpellOnPlayers(uiSpellId);

            // not if solo mini-boss fight
            if (instance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
                return;

            // Twilight Revenge to main boss
            if (Unit* pSartharion = Unit::GetUnit(*me, instance->GetData64(DATA_SARTHARION)))
            {
                if (pSartharion->isAlive())
                {
                    pSartharion->RemoveAurasDueToSpell(uiSpellId);

                    if (Aura* revengeAura = pSartharion->GetAura(SPELL_TWILIGHT_REVENGE))
                    {
                        revengeAura->SetCharges(revengeAura->GetCharges() + 1);
                        revengeAura->SetStackAmount(revengeAura->GetStackAmount() + 1);
                    }
                    else
                    {
                        me->AddAura(SPELL_TWILIGHT_REVENGE, pSartharion);
                    }
                }
            }
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (m_bCanMoveFree && m_uiMoveNextTimer)
        {
            if (m_uiMoveNextTimer <= uiDiff)
            {
                if (m_uiWaypointId < MAX_WAYPOINT)
                    if (me->GetMotionMaster())
                        me->GetMotionMaster()->MovePoint(m_uiWaypointId, m_aDragonCommon[m_uiWaypointId].GetPositionX(), m_aDragonCommon[m_uiWaypointId].GetPositionY(), m_aDragonCommon[m_uiWaypointId].GetPositionZ());

//                debug_log("dummy_dragonAI: %s moving to point %u", me->GetName(), m_uiWaypointId);
                m_uiMoveNextTimer = 0;
            }
            else
                m_uiMoveNextTimer -= uiDiff;
        }
    }
};

/*######
## Mob Tenebron
######*/

class mob_tenebron : public CreatureScript
{
public:
    mob_tenebron() : CreatureScript("mob_tenebron") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_tenebronAI(creature);
    }

    struct mob_tenebronAI : public dummy_dragonAI
    {
        mob_tenebronAI(Creature* creature) : dummy_dragonAI(creature) {}

        uint32 m_uiShadowBreathTimer;
        uint32 m_uiShadowFissureTimer;
        uint32 m_uiHatchEggTimer;

        bool m_bHasPortalOpen;

        void Reset()
        {
            me->ResetLootMode();

            m_uiShadowBreathTimer = 20000;
            m_uiShadowFissureTimer = 5000;
            m_uiHatchEggTimer = 30000;

            m_bHasPortalOpen = false;

            dummy_dragonAI::Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_TENEBRON_AGGRO, me);
            DoZoneInCombat();
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_TENEBRON_SLAY_1, SAY_TENEBRON_SLAY_2), me);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            //if no target, update dummy and return
            if (!UpdateVictim())
            {
                dummy_dragonAI::UpdateAI(uiDiff);
                return;
            }

            // shadow fissure
            if (m_uiShadowFissureTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(target, RAID_MODE(SPELL_SHADOW_FISSURE, SPELL_SHADOW_FISSURE_H));

                m_uiShadowFissureTimer = urand(15000, 20000);
            }
            else
                m_uiShadowFissureTimer -= uiDiff;

            // Hatch Egg
            if (m_uiHatchEggTimer <= uiDiff)
            {
                OpenPortal();
                m_uiHatchEggTimer = urand(45000, 70000);
            }
            else
                 m_uiHatchEggTimer -= uiDiff;

            // shadow breath
            if (m_uiShadowBreathTimer <= uiDiff)
            {
                DoScriptText(SAY_TENEBRON_BREATH, me);
                DoCast(me->getVictim(), RAID_MODE(SPELL_SHADOW_BREATH, SPELL_SHADOW_BREATH_H));
                m_uiShadowBreathTimer = urand(20000, 25000);
            }
            else
                m_uiShadowBreathTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};


/*######
## Mob Shadron
######*/

class mob_shadron : public CreatureScript
{
public:
    mob_shadron() : CreatureScript("mob_shadron") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_shadronAI(creature);
    }

    struct mob_shadronAI : public dummy_dragonAI
    {
        mob_shadronAI(Creature* creature) : dummy_dragonAI(creature) {}

        uint32 m_uiShadowBreathTimer;
        uint32 m_uiShadowFissureTimer;
        uint32 m_uiAcolyteShadronTimer;

        bool m_bHasPortalOpen;

        void Reset()
        {
            me->ResetLootMode();

            m_uiShadowBreathTimer = 20000;
            m_uiShadowFissureTimer = 5000;
            m_uiAcolyteShadronTimer = 60000;

            if (me->HasAura(SPELL_GIFT_OF_TWILIGTH_SHA))
                me->RemoveAurasDueToSpell(SPELL_GIFT_OF_TWILIGTH_SHA);

            m_bHasPortalOpen = false;

            dummy_dragonAI::Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_SHADRON_AGGRO, me);
            DoZoneInCombat();
        }

        void JustDied(Unit* killer)
        {
            if (instance)
                if (Unit* Sartharion = Unit::GetUnit((*me), instance->GetData64(DATA_SARTHARION)))
                    if (Sartharion->HasAura(SPELL_GIFT_OF_TWILIGTH_SAR))
                        Sartharion->RemoveAurasDueToSpell(SPELL_GIFT_OF_TWILIGTH_SAR);

            if (killer)
                dummy_dragonAI::JustDied(killer);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_SHADRON_SLAY_1, SAY_SHADRON_SLAY_2), me);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            //if no target, update dummy and return
            if (!UpdateVictim())
            {
                dummy_dragonAI::UpdateAI(uiDiff);
                return;
            }

            // shadow fissure
            if (m_uiShadowFissureTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(target, RAID_MODE(SPELL_SHADOW_FISSURE, SPELL_SHADOW_FISSURE_H));

                m_uiShadowFissureTimer = urand(15000, 20000);
            }
            else
                m_uiShadowFissureTimer -= uiDiff;

            // Portal Event
            if (m_uiAcolyteShadronTimer <= uiDiff)
            {
                if (m_bHasPortalOpen)
                    m_uiAcolyteShadronTimer = 10000;
                else
                {
                    OpenPortal();
                    m_bHasPortalOpen = true;
                    m_uiAcolyteShadronTimer = urand(45000, 70000);
                }
            }
            else
                m_uiAcolyteShadronTimer -= uiDiff;

            // shadow breath
            if (m_uiShadowBreathTimer <= uiDiff)
            {
                DoScriptText(SAY_SHADRON_BREATH, me);
                DoCast(me->getVictim(), RAID_MODE(SPELL_SHADOW_BREATH, SPELL_SHADOW_BREATH_H));
                m_uiShadowBreathTimer = urand(20000, 25000);
            }
            else
                m_uiShadowBreathTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};


/*######
## Mob Vesperon
######*/

class mob_vesperon : public CreatureScript
{
public:
    mob_vesperon() : CreatureScript("mob_vesperon") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_vesperonAI(creature);
    }

    struct mob_vesperonAI : public dummy_dragonAI
    {
        mob_vesperonAI(Creature* creature) : dummy_dragonAI(creature) {}

        uint32 m_uiShadowBreathTimer;
        uint32 m_uiShadowFissureTimer;
        uint32 m_uiAcolyteVesperonTimer;

        bool m_bHasPortalOpen;

        void Reset()
        {
            me->ResetLootMode();

            HandleAuraOnRaidSartharion(me, SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER, true, false, 0, false, false);
            HandleAuraOnRaidSartharion(me, SPELL_TWILIGHT_TORMENT_VESP_ACO_ON_PLAYER, true, false, 0, false, false);

            m_uiShadowBreathTimer = 20000;
            m_uiShadowFissureTimer = 5000;
            m_uiAcolyteVesperonTimer = 60000;

            m_bHasPortalOpen = false;

            dummy_dragonAI::Reset();
        }

        void JustDied(Unit* killer)
        {
            HandleAuraOnRaidSartharion(me, SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER, true, false, 0, false, false);
            HandleAuraOnRaidSartharion(me, SPELL_TWILIGHT_TORMENT_VESP_ACO_ON_PLAYER, true, false, 0, false, false);

            if (killer)
                dummy_dragonAI::JustDied(killer);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_VESPERON_AGGRO, me);
            DoZoneInCombat();
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_VESPERON_SLAY_1, SAY_VESPERON_SLAY_2), me);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            //if no target, update dummy and return
            if (!UpdateVictim())
            {
                dummy_dragonAI::UpdateAI(uiDiff);
                return;
            }

            // shadow fissure
            if (m_uiShadowFissureTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(target, RAID_MODE(SPELL_SHADOW_FISSURE, SPELL_SHADOW_FISSURE_H));

                m_uiShadowFissureTimer = urand(15000, 20000);
            }
            else
                m_uiShadowFissureTimer -= uiDiff;

            // Portal Event
            if (m_uiAcolyteVesperonTimer <= uiDiff)
            {
                if (m_bHasPortalOpen)
                    m_uiAcolyteVesperonTimer = 10000;
                else
                {
                    OpenPortal();
                    HandleAuraOnRaidSartharion(me, SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER, true, true, 1, false, true);
                    m_uiAcolyteVesperonTimer = urand(45000, 70000);
                }
            }
            else
                m_uiAcolyteVesperonTimer -= uiDiff;

            // shadow breath
            if (m_uiShadowBreathTimer <= uiDiff)
            {
                DoScriptText(SAY_VESPERON_BREATH, me);
                DoCast(me->getVictim(), RAID_MODE(SPELL_SHADOW_BREATH, SPELL_SHADOW_BREATH_H));
                m_uiShadowBreathTimer = urand(20000, 25000);
            }
            else
                m_uiShadowBreathTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};


/*######
## Mob Acolyte of Shadron
######*/

class mob_acolyte_of_shadron : public CreatureScript
{
public:
    mob_acolyte_of_shadron() : CreatureScript("mob_acolyte_of_shadron") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_acolyte_of_shadronAI(creature);
    }

    struct mob_acolyte_of_shadronAI : public ScriptedAI
    {
        mob_acolyte_of_shadronAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        uint32 uiDespawnTimer;
     
        void Reset()
        {
            uiDespawnTimer = 35000;
            if (instance)
            {
                Creature* target = NULL;
                //if not solo figth, buff main boss, else place debuff on mini-boss. both spells TARGET_SCRIPT
                if (instance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
                {
                    if (target = ((Creature*)Unit::GetUnit((*me), instance->GetData64(DATA_SARTHARION))))
                        target->AddAura(SPELL_GIFT_OF_TWILIGTH_SAR, target);
                }
                else
                {
                    if (target = ((Creature*)Unit::GetUnit((*me), instance->GetData64(DATA_SHADRON))))
                        target->AddAura(SPELL_GIFT_OF_TWILIGTH_SHA, target);
                }
             }

            if (!me->HasAura(SPELL_TWILIGHT_SHIFT_ENTER))
                me->AddAura(SPELL_TWILIGHT_SHIFT_ENTER, me);
        }

        void JustDied(Unit* killer)
        {
            if (instance)
            {
                Creature* Shadron = instance->instance->GetCreature(instance->GetData64(DATA_SHADRON));
                if (Shadron)
                {
                    (CAST_AI(mob_shadron::mob_shadronAI, Shadron->AI()))->m_bHasPortalOpen = false;
                }

                Creature* pDebuffTarget = NULL;

                if (killer)
                {
                    if (killer->GetTypeId() == TYPEID_PLAYER || (killer->GetOwner() && killer->GetOwner()->GetTypeId() == TYPEID_PLAYER))
                    {
                        //not solo fight, so main boss has deduff
                        pDebuffTarget = instance->instance->GetCreature(instance->GetData64(DATA_SARTHARION));
                        if (pDebuffTarget)
                            if (pDebuffTarget->isAlive() && pDebuffTarget->HasAura(SPELL_GIFT_OF_TWILIGTH_SAR))
                                pDebuffTarget->RemoveAurasDueToSpell(SPELL_GIFT_OF_TWILIGTH_SAR);

                        //event not in progress, then solo fight and must remove debuff mini-boss
                        pDebuffTarget = instance->instance->GetCreature(instance->GetData64(DATA_SHADRON));
                        if (pDebuffTarget)
                            if (pDebuffTarget->isAlive() && pDebuffTarget->HasAura(SPELL_GIFT_OF_TWILIGTH_SHA))
                                pDebuffTarget->RemoveAurasDueToSpell(SPELL_GIFT_OF_TWILIGTH_SHA);
                    }
                }
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (uiDespawnTimer < uiDiff)
            {
                me->SetVisible(false);
                me->Kill(me);
                return;
            }else uiDespawnTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

};


/*######
## Mob Acolyte of Vesperon
######*/

class mob_acolyte_of_vesperon : public CreatureScript
{
public:
    mob_acolyte_of_vesperon() : CreatureScript("mob_acolyte_of_vesperon") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_acolyte_of_vesperonAI(creature);
    }

    struct mob_acolyte_of_vesperonAI : public ScriptedAI
    {
        mob_acolyte_of_vesperonAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        uint32 uiDespawnTimer;

        void Reset()
        {
            uiDespawnTimer = 35000;

            if (!me->HasAura(SPELL_TWILIGHT_SHIFT_ENTER))
                me->AddAura(SPELL_TWILIGHT_SHIFT_ENTER, me);

            HandleAuraOnRaidSartharion(me, SPELL_TWILIGHT_TORMENT_VESP_ACO_ON_PLAYER, true, true, 1, true, false);
        }

        void JustDied(Unit* killer)
        {
            // remove twilight torment on Vesperon
            if (instance)
            {
                HandleAuraOnRaidSartharion(me, SPELL_TWILIGHT_TORMENT_VESP_ACO_ON_PLAYER, true, false, 0, false, false);

                Creature* pVesperon = instance->instance->GetCreature(instance->GetData64(DATA_VESPERON));
                if (pVesperon)
                {
                    if (pVesperon->isInCombat())
                    {
                        (CAST_AI(mob_vesperon::mob_vesperonAI, pVesperon->AI()))->m_bHasPortalOpen = false;

                        if (killer)
                        {
                            if (killer->GetTypeId() == TYPEID_PLAYER || (killer->GetOwner() && killer->GetOwner()->GetTypeId() == TYPEID_PLAYER))
                            {
                                // Killed by player, so remove initial stack
                                HandleAuraOnRaidSartharion(me, SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER, true, false, 0, false, false);
                            }
                        }
                    }
                }
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (uiDespawnTimer < uiDiff)
            {
                me->SetVisible(false);
                me->Kill(me);
                return;
            }else uiDespawnTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

};


/*######
## Mob Twilight Eggs
######*/

class mob_twilight_eggs : public CreatureScript
{
public:
    mob_twilight_eggs() : CreatureScript("mob_twilight_eggs") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_twilight_eggsAI(creature);
    }

    struct mob_twilight_eggsAI : public Scripted_NoMovementAI
    {
        mob_twilight_eggsAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        uint32 m_uiHatchEggTimer;

        InstanceScript* instance;

        void Reset()
        {
            if (!me->HasAura(SPELL_TWILIGHT_SHIFT_ENTER))
                me->AddAura(SPELL_TWILIGHT_SHIFT_ENTER, me);

            m_uiHatchEggTimer = 30000;
        }

        void SpawnWhelps()
        {
            me->RemoveAllAuras();

            Position spawnPos;
            me->GetPosition(&spawnPos);

            if (Creature* whelp = me->SummonCreature(NPC_TWILIGHT_WHELP, spawnPos, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 300000))
            {
                DoZoneInCombat(whelp);
            }

            me->Kill(me);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_uiHatchEggTimer <= uiDiff)
            {
                if (instance)
                {
                    Creature* Tenebron = instance->instance->GetCreature(instance->GetData64(DATA_TENEBRON));

                    if (Tenebron)
                        (CAST_AI(mob_tenebron::mob_tenebronAI, Tenebron->AI()))->m_bHasPortalOpen = false;

                    SpawnWhelps();
                }
            }
            else
                m_uiHatchEggTimer -= uiDiff;
        }
        

        void AttackStart(Unit* /*who*/) {}
        void MoveInLineOfSight(Unit* /*who*/) {}
    };

};


/*######
## Mob Flame Tsunami
######*/
class npc_flame_tsunami : public CreatureScript
{
public:
    npc_flame_tsunami() : CreatureScript("npc_flame_tsunami") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_flame_tsunamiAI(creature);
    }

    struct npc_flame_tsunamiAI : public ScriptedAI
    {
        npc_flame_tsunamiAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetDisplayId(11686);

            if (!me->HasAura(SPELL_FLAME_TSUNAMI))
                me->AddAura(SPELL_FLAME_TSUNAMI, me);
        }

        uint32 Tsunami_Timer;
        uint32 TsunamiBuff_timer;

        bool isRightDirection;
        bool isLeftDirection;

        void Reset()
        {
            Tsunami_Timer = 100;
            me->setFaction(14);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            TsunamiBuff_timer = 1000;

            isRightDirection = false;
            isLeftDirection = false;
        }

        void SetData(uint32 type, uint32 value)
        {
            if (type == 1)
            {
                switch (value)
                {
                    case 1:
                        isRightDirection = true;
                        break;
                    case 2:
                        isLeftDirection = true;
                        break;
                }
            }
        }

        void SpellHitTarget(Unit* target, const SpellInfo* pSpell)
        {
            if (!target)
                return;

            if (target == me)
                return;

            if (target->GetTypeId() != TYPEID_PLAYER)
                return;

            if (pSpell)
            {
                if (pSpell->Id == SPELL_FLAME_TSUNAMI_DMG_AURA)
                {
                    if (isRightDirection)
                    {
                        if (target->GetPositionX() > 3276.0)
                            return;

                        if (target->GetMotionMaster())
                            target->GetMotionMaster()->MoveJump(me->GetPositionX() + 4, me->GetPositionY(), 60.0f, 20, 5);
                    }

                    if (isLeftDirection)
                    {
                        if (target->GetPositionX() < 3207.0)
                            return;

                        if (target->GetMotionMaster())
                            target->GetMotionMaster()->MoveJump(me->GetPositionX() - 4, me->GetPositionY(), 60.0f, 20, 5);
                    }
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (Tsunami_Timer <= diff)
            {
                DoCast(me, SPELL_FLAME_TSUNAMI_DMG_AURA);
                Tsunami_Timer = 500;
            }else Tsunami_Timer -= diff;
            
            if (TsunamiBuff_timer <= diff)
            {
                if (Unit* LavaBlaze = GetClosestCreatureWithEntry(me, NPC_LAVA_BLAZE, 10.0f, true))
                    LavaBlaze->CastSpell(LavaBlaze, SPELL_FLAME_TSUNAMI_BUFF, true);
                TsunamiBuff_timer = 1000;
            }else TsunamiBuff_timer -= diff;
        }

        void AttackStart(Unit* who) {}
        void MoveInLineOfSight(Unit* who) {}
    };
};

// Twilight Fissure
class npc_twilight_fissure : public CreatureScript
{
public:
    npc_twilight_fissure() : CreatureScript("npc_twilight_fissure") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_twilight_fissureAI(creature);
    }

    struct npc_twilight_fissureAI : public Scripted_NoMovementAI
    {
        npc_twilight_fissureAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            Reset();
        }

        uint32 VoidBlast_Timer;

        void Reset()
        {
            me->SetReactState(REACT_PASSIVE);
            me->setFaction(14);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            VoidBlast_Timer = 5000;
        }

        void UpdateAI(const uint32 diff)
        {
            if (VoidBlast_Timer <= diff)
            {
                DoCastAOE(RAID_MODE(SPELL_VOID_BLAST, SPELL_VOID_BLAST_H));
                me->RemoveAllAuras();
                me->Kill(me);
            } else VoidBlast_Timer -= diff;
        }
    };

};




/*######
## Mob Twilight Whelps
######*/

class mob_twilight_whelp : public CreatureScript
{
public:
    mob_twilight_whelp() : CreatureScript("mob_twilight_whelp") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_twilight_whelpAI(creature);
    }

    struct mob_twilight_whelpAI : public ScriptedAI
    {
        mob_twilight_whelpAI(Creature* creature) : ScriptedAI(creature)
        {
            Reset();
        }

        uint32 m_uiFadeArmorTimer;

        void Reset()
        {
            me->RemoveAllAuras();
            m_uiFadeArmorTimer = 1000;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            // twilight torment
            if (m_uiFadeArmorTimer <= uiDiff)
            {
                DoCast(me->getVictim(), SPELL_FADE_ARMOR);
                m_uiFadeArmorTimer = urand(5000, 10000);
            }
            else
                m_uiFadeArmorTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

class achievement_twilight_assist : public AchievementCriteriaScript
{
    public:
        achievement_twilight_assist() : AchievementCriteriaScript("achievement_twilight_assist")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            if (Creature* Sartharion = target->ToCreature())
                if (Sartharion->AI()->GetData(TWILIGHT_ACHIEVEMENTS) >= 1)
                    return true;

            return false;
        }
};

class achievement_twilight_duo : public AchievementCriteriaScript
{
    public:
        achievement_twilight_duo() : AchievementCriteriaScript("achievement_twilight_duo")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            if (Creature* Sartharion = target->ToCreature())
                if (Sartharion->AI()->GetData(TWILIGHT_ACHIEVEMENTS) >= 2)
                    return true;

            return false;
        }
};

class achievement_twilight_zone : public AchievementCriteriaScript
{
    public:
        achievement_twilight_zone() : AchievementCriteriaScript("achievement_twilight_zone")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            if (Creature* Sartharion = target->ToCreature())
                if (Sartharion->AI()->GetData(TWILIGHT_ACHIEVEMENTS) == 3)
                    return true;

            return false;
        }
};

class achievement_volcano_blows : public AchievementCriteriaScript
{
    public:
        achievement_volcano_blows() : AchievementCriteriaScript("achievement_volcano_blows")
        {
        }

        bool OnCheck(Player* player, Unit* target)
        {
            if (!target)
                return false;

            if (boss_sartharion::boss_sartharionAI* sartharionAI = CAST_AI(boss_sartharion::boss_sartharionAI, target->GetAI()))
                return sartharionAI->wasPlayerHitByLavaStrike(player->GetGUID());

            return false;
        }
};


class go_portal_sartharion : public GameObjectScript
{
    public:

    go_portal_sartharion() : GameObjectScript("go_portal_sartharion")
    {
    }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        if (!player || !go)
            return true;

        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if (instance->instance)
            {
                // Player from twilight => real world
                if (player->HasAura(SPELL_TWILIGHT_SHIFT_ENTER))
                {
                    player->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT);
                    player->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT_ENTER);
                    player->CastSpell(player, SPELL_TWILIGHT_RESIDUE, true);

                    // Special Vesperon support
                    if (Creature* Vesperon = instance->instance->GetCreature(instance->GetData64(DATA_VESPERON)))
                    {
                        if (Vesperon->getVictim() && Vesperon->isInCombat())
                        {
                            if (player->HasAura(SPELL_TWILIGHT_TORMENT_VESP_ACO_ON_PLAYER))
                                player->RemoveAurasDueToSpell(SPELL_TWILIGHT_TORMENT_VESP_ACO_ON_PLAYER);

                            // Vesperons victim has torment, so add torment on player entering the realm world too
                            if (Vesperon->getVictim()->HasAura(SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER))
                            {
                                if (Aura* aur = Vesperon->AddAura(SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER, player))
                                {
                                    aur->SetStackAmount(1);
                                    aur->SetCharges(1);
                                }
                            }
                        }
                    }
                }
                // Player from real world => twilight world
                else
                {
                    Creature* Sartharion = instance->instance->GetCreature(instance->GetData64(DATA_SARTHARION));
                    Creature* Vesperon = instance->instance->GetCreature(instance->GetData64(DATA_VESPERON));
                    Creature* Shadron = instance->instance->GetCreature(instance->GetData64(DATA_SHADRON));
                    Creature* Tenebron = instance->instance->GetCreature(instance->GetData64(DATA_TENEBRON));

                    if (Sartharion)
                    {
                        if (Sartharion->getVictim())
                        {
                            if (Sartharion->getVictim() == player)
                                return true;

                            if (Sartharion->getVictim()->GetOwner())
                                if (Sartharion->getVictim()->GetOwner() == player)
                                    return true;
                        }
                    }

                    if (Vesperon)
                    {
                        if (Vesperon->getVictim())
                        {
                            if (Vesperon->getVictim() == player)
                                return true;

                            if (Vesperon->getVictim()->GetOwner())
                                if (Vesperon->getVictim()->GetOwner() == player)
                                    return true;
                        }
                    }

                    if (Tenebron)
                    {
                        if (Tenebron->getVictim())
                        {
                            if (Tenebron->getVictim() == player)
                                return true;

                            if (Tenebron->getVictim()->GetOwner())
                                if (Tenebron->getVictim()->GetOwner() == player)
                                    return true;
                        }
                    }

                    if (Shadron)
                    {
                        if (Shadron->getVictim())
                        {
                            if (Shadron->getVictim() == player)
                                return true;

                            if (Shadron->getVictim()->GetOwner())
                                if (Shadron->getVictim()->GetOwner() == player)
                                    return true;
                        }
                    }

                    if (!player->HasAura(SPELL_TWILIGHT_RESIDUE))
                    {
                        player->CastSpell(player, SPELL_TWILIGHT_SHIFT_ENTER, true);

                        // Special Vesperon support
                        if (Vesperon)
                        {
                            if (Vesperon->isInCombat())
                            {
                                // Vesperon has an acolyte summoned, so add aura on portal enter
                                if (go->FindNearestCreature(NPC_ACOLYTE_OF_VESPERON, 100.0f, true))
                                {
                                    if (Aura* acoAur = player->AddAura(SPELL_TWILIGHT_TORMENT_VESP_ACO_ON_PLAYER, player))
                                    {
                                        acoAur->SetStackAmount(1);
                                        acoAur->SetCharges(1);
                                    }
                                }

                                if (player->HasAura(SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER))
                                    player->RemoveAurasDueToSpell(SPELL_TWILIGHT_TORMENT_VESP_ON_PLAYER);
                            }
                        }
                    }
                }
            }
        }

        return true;
    }
};

void AddSC_boss_sartharion()
{
    new boss_sartharion();
    new mob_vesperon();
    new mob_shadron();
    new mob_tenebron();
    new mob_acolyte_of_shadron();
    new mob_acolyte_of_vesperon();
    new mob_twilight_eggs();
    new npc_flame_tsunami();
    new npc_twilight_fissure();
    new mob_twilight_whelp();
    new achievement_twilight_assist();
    new achievement_twilight_duo();
    new achievement_twilight_zone();
    new achievement_volcano_blows();
    new go_portal_sartharion();
}
