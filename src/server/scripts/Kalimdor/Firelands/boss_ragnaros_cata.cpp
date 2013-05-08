
/*
Script:     Ragnaros Encounter
Complete:   80%
Author:     Northstrider
Todo:
-Correct the positions of the engulfing flames (center got a circle of the border lane)
-Molten Seed doesn't attack in any reason o.O
-Lava Scions doesn't attack -.-
-25 player mode
-heroic mode

!WARNING!
This code is developed and owned by Northstrider (Dreadii).
If you steal this code (copy pasting without copyrights) this project will
instantly get canceled.
*/

#include "firelands.h"

enum Texts
{
    SAY_ARRIVE          = 0,
    SAY_DEATH_NORMAL    = 1,
    SAY_DEATH_HEROIC    = 2,
    SAY_SLAY            = 3,
    SAY_ANNOUNCE_SPLIT  = 4,
    SAY_HAMMER_DROP     = 5,
    SAY_HAMMER_PICKUP   = 6,
    SAY_SONS_OF_FLAME   = 7,
    SAY_ANNOUNCE_EMERGE = 8,
    SAY_MAGMA_TRAP      = 9,
    SAY_SULFURAS_SMASH  = 10,
};

enum Spells
{
    // Ragnaros Base Auras
    SPELL_BASE_VISUAL                       = 98860,
    SPELL_BURNING_WOUNDS_AURA               = 99401,

    // Spell Sulfuras Smash
    SPELL_SULFURAS_SMASH_DUMMY              = 98703, // Seems like this summoned npc is just the orientation dummy
    SPELL_SULFURAS_SMASH                    = 98710,
    SPELL_SULFURAS_SMASH_MISSILE            = 98708,
    SPELL_SULFURAS_SMASH_TARGET             = 98706,

    // Lava Wave Summons
    SPELL_LAVA_WAVE_DUMMY_NORTH             = 98874,
    SPELL_LAVA_WAVE_DUMMY_EAST              = 98875,
    SPELL_LAVA_WAVE_DUMMY_WEST              = 98876,
    SPELL_LAVA_POOL                         = 98712,
    SPELL_SCORCHED_GROUND                   = 98871,

    // Magma Strike
    SPELL_MAGMA_STRIKE                      = 98313,

    // Magma Trap
    SPELL_MAGMA_TRAP                        = 98164,
    SPELL_MAGMA_TRAP_SONAR                  = 98159, // For what is this ?
    SPELL_MAGMA_TRAP_VISUAL                 = 98179,
    SPELL_MAGMA_TRAP_PERIODIC               = 98172,
    SPELL_MAGMA_TRAP_PERIODIC_TICK          = 98171,
    SPELL_MAGMA_TRAP_ERUPTION               = 98175,

    // Hand of Ragnaros
    SPELL_HAND_OF_RAGNAROS                  = 98237,

    // Wrath of Ragnaros
    SPELL_WRATH_OF_RAGNAROS                 = 98263,

    // Lava Wave
    SPELL_LAVA_WAVE                         = 98873,

    // Splitting Blow
    SPELL_SUBMERGE                          = 100051,
    SPELL_SUBMERGE_AURA                     = 98982,
    SPELL_SPLITTING_BLOW_WEST               = 98953,
    SPELL_SPLITTING_BLOW_NORTH              = 98952,
    SPELL_SPLITTING_BLOW_EAST               = 98951,

    // Sulfuras, Hand of Ragnaros
    SPELL_INVOKE_SONS                       = 99054,
    SPELL_INVOKE_SONS_MISSILE               = 99050,
    SPELL_INVOKE_SONS_TRIGGERED_SPELL       = 99051,
    SPELL_SULFURAS_AURA                     = 100456,

    // Son of Flame
    SPELL_HIT_ME                            = 100446,
    SPELL_PRE_VISUAL                        = 98983,
    SPELL_BURNING_SPEED                     = 98473,
    SPELL_BURNING_SPEED_STACKS              = 99414,
    SPELL_SUPERNOVA                         = 99112,

    // Engulfing Flames
    SPELL_ENGULFING_FLAMES_BOTTOM           = 99236,
    SPELL_ENGULFING_FLAMES_CENTER           = 99235,
    SPELL_ENGULFING_FLAMES_MELEE            = 99172,
    SPELL_ENGULFING_FLAMES_VISUAL_MELEE     = 99216,
    SPELL_ENGULFING_FLAMES_VISUAL_CENTER    = 99217,
    SPELL_ENGULFING_FLAMES_VISUAL_BOTTOM    = 99218,

    // Molten Seed
    SPELL_MOLTEN_SEED                       = 98333,
    SPELL_MOLTEN_SEED_SUMMON                = 100141,

    SPELL_MOLTEN_SEED_MISSILE               = 98495,
    SPELL_MOLTEN_SEED_DAMAGE                = 98498,
    SPELL_UNK_1                             = 98497, // don't know yet for what this spell is

    // Molten Elemental
    SPELL_INVISIBLE_PRE_VISUAL              = 100153,
    SPELL_MOLTEN_SEED_VISUAL                = 98520,
    SPELL_MOLTEN_INFERNO                    = 98518,
    SPELL_MOLTEN_POWER_AURA                 = 100157,
    SPELL_MOLTEN_POWER_PERIODIC             = 100158,

    // Lava Scion
    SPELL_BLAZING_HEAT                      = 100460,
    SPELL_BLAZING_HEAT_SONAR                = 100459,

    // Blazing Heat
    SPELL_BLAZING_HEAT_AURA                 = 99126,
    SPELL_BLAZING_HEAT_SUMMON               = 99129,
    SPELL_BLAZING_HEAT_DUMMY                = 99125,
    SPELL_BLAZING_HEAT_DAMAGE_AURA          = 99128,

    // Living Meteor
    SPELL_LIVING_METEOR_MISSILE             = 99268,
    SPELL_LIVING_METEOR_DAMAGE_REDUCTION    = 100904,
    SPELL_LIVING_METEOR_COMBUSTIBLE         = 99296,
    SPELL_LIVING_METEOR_COMBUSTITION        = 99303, // Knockback Spell (only castable if the meteor has the aura)
    SPELL_LIVING_METEOR_EXPLOSION_TRIGGER   = 99269,
    SPELL_LIVING_METEOR_INCREASE_SPEED      = 100278,
    SPELL_LIVING_METEOR_FIXATE              = 99849,
    SPELL_LIVING_METEOR_UNK                 = 99267,
    SPELL_LIVING_METEOR_EXPLOSION           = 99287,
};

enum Phases
{
    PHASE_INTRO             = 1,
    PHASE_1                 = 2,
    PHASE_2                 = 3,
    PHASE_3                 = 4,
    PHASE_SUBMERGED         = 5,
    PHASE_HEROIC            = 6,
};

enum Events
{
    // Ragnaros
    EVENT_INTRO                     = 1,
    EVENT_ATTACK                    = 2,
    EVENT_SULFURAS_SMASH_TRIGGER    = 3,
    EVENT_SULFURAS_SMASH            = 4,
    EVENT_MAGMA_TRAP                = 5,
    EVENT_WRATH_OF_RAGNAROS         = 6,
    EVENT_HAND_OF_RAGNAROS          = 7,
    EVENT_SPLITTING_BLOW            = 8,
    EVENT_CALL_SONS                 = 9,
    EVENT_ANNOUNCE_EMERGE           = 10,
    EVENT_EMERGE                    = 11,
    EVENT_ENGULFING_FLAMES          = 12,
    EVENT_MOLTEN_SEED               = 13,
    EVENT_LIVING_METEOR             = 14,

    // Sulfuras Smash
    EVENT_SCORCH                    = 20,
    EVENT_MOVE_LAVA_WAVE            = 21,
    EVENT_SUMMON_WAVE_1             = 22,
    EVENT_SUMMON_WAVE_2             = 23,
    EVENT_SUMMON_WAVE_3             = 24,

    // Magma Trap
    EVENT_PREPARE_TRAP              = 25,

    // Son of Flame
    EVENT_MOVE_HAMMER               = 26, // We gonna schedule this every 2 seconds to prevent any stucking movement

    // Sulfuras, Hand of Ragnaros
    EVENT_CHECK_SONS                = 27,

    // Molten Elemental
    EVENT_ACTIVATE                  = 28,

    // Lava Scion
    EVENT_BLAZING_HEAT              = 29,

    // Living Meteor
    EVENT_STALK_PLAYER              = 30,
    EVENT_KILL_PLAYER               = 31,
    EVENT_ENABLE_KNOCKBACK          = 32,
};

enum Actions
{
    ACTION_SON_KILLED       = 1,
    ACTION_ACTIVATE_SON     = 2,
    ACTION_INSTANT_EMERGE   = 3,
};

enum AnimKits
{
    // Ragnaros
    ANIM_KIT_RESURFACE  = 1465,
    ANIM_KIT_EMERGE     = 1467,
    ANIM_KIT_TAUNT      = 1468,
    ANIM_KIT_STAND_UP   = 1486,

    // Son of Flame
    ANIM_KIT_UNK_1      = 1370,
};

Position const RagnarosSummonPosition = {1075.201f, -57.84896f, 55.42427f,  3.159046f   };
Position const SplittingTriggerNorth  = {1023.55f,  -57.158f,   55.4215f,   3.12414f    };
Position const SplittingTriggerEast   = {1035.45f,  -25.3646f,  55.4924f,   2.49582f    };
Position const SplittingTriggerWest   = {1036.27f,  -89.2396f,  55.5098f,   3.83972f    };

const Position SonsOfFlameWest[] =
{
    {999.533f,  -45.74826f, 55.56229f, 5.009095f},
    {1065.372f, -108.8698f, 55.56829f, 2.373648f},
    {1034.168f, -15.93056f, 55.60827f, 4.049164f},
    {1051.76f,  0.1284722f, 55.44715f, 4.031711f},
    {1014.134f, -43.94445f, 55.42412f, 3.979351f},
    {1068.151f, -101.3924f, 55.56828f, 2.565634f},
    {1051.497f, -113.7292f, 55.44935f, 2.391101f},
    {1074.866f, -100.7882f, 55.42414f, 2.600541f},
};

const Position SonsOfFlameNorth[] =
{
    {1065.372f, -108.8698f, 55.56829f, 2.373648f},
    {1030.372f, -23.63715f, 55.44154f, 4.049164f},
    {1014.325f, -88.80209f, 55.52722f, 1.919862f},
    {1051.760f, 0.1284722f, 55.44715f, 4.031711f},
    {1012.120f, -26.89063f, 55.564f,   4.398230f},
    {1055.556f, -8.875f,    55.43348f, 3.874631f},
    {1040.394f, -91.81944f, 55.42585f, 2.234021f},
    {1065.257f, -6.946181f, 55.56818f, 3.839724f},
};

const Position SonsOfFlameEast[] =
{
    {1013.458f, -68.08507f, 55.42097f, 2.513274f},
    {1065.372f, -108.8698f, 55.56829f, 2.373648f},
    {1042.033f, -114.9132f, 55.44709f, 1.919862f},
    {1051.76f,  0.1284722f, 55.44715f, 4.031711f},
    {1061.34f, -16.74132f, 55.56819f, 3.769911f},
    {1051.497f, -113.7292f, 55.44935f, 2.391101f},
    {1024.845f, -97.67882f, 55.52884f, 2.234021f},
    {1074.866f, -100.7882f, 55.42414f, 2.600541f},
};

const Position EngulfingFlamesMelee[] =
{
    {1086.55f, -18.0885f, 55.4228f, 1.57080f},
    {1091.83f, -21.9254f, 55.4241f, 4.71239f},
    {1092.52f, -92.3924f, 55.4241f, 4.71239f},
    {1079.15f, -15.5312f, 55.4230f, 4.71239f},
    {1078.01f, -97.7760f, 55.4227f, 1.57080f},
    {1065.44f, -17.7049f, 55.4250f, 5.00910f},
    {1063.59f, -97.0573f, 55.4934f, 1.23918f},
    {1051.80f, -24.0903f, 55.4258f, 5.41052f},
    {1049.27f, -90.6892f, 55.4259f, 0.89011f},
    {1042.34f, -32.1059f, 55.4254f, 5.68977f},
    {1041.26f, -81.4340f, 55.4240f, 0.57595f},
    {1036.82f, -44.3385f, 55.4425f, 6.02139f},
    {1036.34f, -69.8281f, 55.4425f, 0.31415f},
    {1034.76f, -63.9583f, 55.4397f, 6.26573f},
    {1033.93f, -57.0920f, 55.4225f, 6.26573f},
    {1086.42f, -96.7812f, 55.4226f, 1.57080f},
};

const Position EngulfingFlamesRange[] =
{
    {1035.17f, -125.646f, 55.4471f, 0.0f},
    {1032.48f,  13.2708f, 55.4469f, 0.0f},
    {1023.83f,  12.9774f, 55.4470f, 0.0f},
    {1023.05f, -128.257f, 55.4471f, 0.0f},
    {1019.60f,  7.76910f, 55.4470f, 0.0f},
    {1018.29f, -117.833f, 55.4471f, 0.0f},
    {1012.70f, -4.83333f, 55.6050f, 0.0f},
    {1009.56f, -108.161f, 55.4697f, 0.0f},
    {1005.80f, -8.81771f, 55.4672f, 0.0f},
    {1000.81f, -14.5069f, 55.4566f, 0.0f},
    {999.755f, -98.4792f, 55.4426f, 0.0f},
    {991.799f, -25.0955f, 55.4441f, 0.0f},
    {991.738f, -87.1632f, 55.4445f, 0.0f},
    {989.866f, -66.0868f, 55.4331f, 0.0f},
    {988.208f, -50.3646f, 55.4291f, 0.0f},
    {986.608f, -37.7656f, 55.4411f, 0.0f},
    {985.180f, -77.3785f, 55.4409f, 0.0f},
    {980.927f, -58.2656f, 55.4542f, 0.0f},
};

const Position EngulfingFlamesCenter[] =
{
    {1069.66f, -4.53993f, 55.4308f, 0.0f},
    {1062.94f, -4.34201f, 55.5682f, 0.0f},
    {1062.13f, -109.005f, 55.4259f, 0.0f},
    {1055.34f, 5.06771f,  55.4471f, 0.0f},
    {1057.03f, -4.10417f, 55.4258f, 0.0f},
    {1049.74f, -118.396f, 55.5661f, 0.0f},
    {1052.59f, -120.562f, 55.4563f, 0.0f},
    {1049.33f, 5.0434f,   55.4633f, 0.0f},
    {1049.98f, -7.22396f, 55.4537f, 0.0f},
    {1049.66f, -104.906f, 55.4556f, 0.0f},
    {1035.91f, 0.909722f, 55.4470f, 0.0f},
    {1035.56f, -114.156f, 55.4471f, 0.0f},
    {1038.53f, -100.254f, 55.6012f, 0.0f},
    {1036.90f, -14.6181f, 55.5715f, 0.0f},
    {1016.99f, -57.5642f, 55.4133f, 0.0f},
    {1030.22f, -92.8403f, 55.4344f, 0.0f},
    {1024.45f, -8.13889f, 55.4470f, 0.0f},
    {1024.45f, -8.13889f, 55.4470f, 0.0f},
    {1024.91f, -106.852f, 55.4471f, 0.0f},
    {1025.34f, -25.8472f, 55.4069f, 0.0f},
    {1025.29f, -86.2326f, 55.4071f, 0.0f},
    {1021.84f, -33.7483f, 55.4239f, 0.0f},
    {1021.49f, -79.6076f, 55.4261f, 0.0f},
    {1018.47f, -43.7674f, 55.4218f, 0.0f},
    {1069.91f, -109.651f, 55.4277f, 0.0f},
    {1014.15f, -17.3281f, 55.4629f, 0.0f},
    {1018.29f, -70.1875f, 55.4231f, 0.0f},
    {1012.09f, -97.5122f, 55.4570f, 0.0f},
    {1006.10f, -27.3681f, 55.4277f, 0.0f},
    {1005.49f, -86.4566f, 55.4275f, 0.0f},
    {1002.72f, -40.7431f, 55.4063f, 0.0f},
    {1003.44f, -74.0243f, 55.4063f, 0.0f},
    {1003.44f, -74.0243f, 55.4063f, 0.0f},
    {1003.07f, -66.4913f, 55.4067f, 0.0f},
    {1002.21f, -49.7049f, 55.4075f, 0.0f},
    {1002.00f, -58.2396f, 55.4331f, 0.0f},
};

const Position LavaScionPos[] =
{
    {1027.306f, -121.7465f, 55.4471f, 1.361f},
    {1026.861f, 5.895833f, 55.44697f, 4.904f},
};

class at_sulfuron_keep : public AreaTriggerScript
{
    public:
        at_sulfuron_keep() : AreaTriggerScript("at_sulfuron_keep") { }

        bool OnTrigger(Player* player, AreaTriggerEntry const* /*areaTrigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
                if (!instance->GetData64(DATA_RAGNAROS))
                    player->SummonCreature(BOSS_RAGNAROS, RagnarosSummonPosition, TEMPSUMMON_MANUAL_DESPAWN, 0);
            return true;
        }
};

class boss_ragnaros_cata : public CreatureScript
{
public:
    boss_ragnaros_cata() : CreatureScript("boss_ragnaros_cata") { }

    struct boss_ragnaros_cataAI : public BossAI
    {
        boss_ragnaros_cataAI(Creature* creature) : BossAI(creature, DATA_RAGNAROS)
        {
            _submergeCounter = 0;
            _sonCounter = 0;
        }

        uint8 _submergeCounter;
        uint8 _sonCounter;

        void Reset()
        {
            _Reset();
            events.SetPhase(PHASE_1);
            instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            me->SetByteValue(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_ALWAYS_STAND | UNIT_BYTE1_FLAG_HOVER);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_PASSIVE);
            _submergeCounter = 0;
            _sonCounter = 0;
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            HandleDoor();
            instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);
            me->SetReactState(REACT_AGGRESSIVE);
            events.SetPhase(PHASE_1);
            events.ScheduleEvent(EVENT_SULFURAS_SMASH_TRIGGER, 30000, 0, PHASE_1);
            events.ScheduleEvent(EVENT_MAGMA_TRAP, 15500, 0, PHASE_1);
            events.ScheduleEvent(EVENT_WRATH_OF_RAGNAROS, 6000, 0, PHASE_1);
            events.ScheduleEvent(EVENT_HAND_OF_RAGNAROS, 25000, 0, PHASE_1);
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
            HandleDoor();
            instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            if (!IsHeroic())
            {
                Talk(SAY_DEATH_NORMAL);
                me->SetHealth(1);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);
                me->DespawnOrUnsummon(6000);
                if (GameObject* cache = me->FindNearestGameObject(GO_CACHE_OF_THE_FIRELORD, 200.0f))
                    cache->SetPhaseMask(1, true);
            }
        }

        void EnterEvadeMode()
        {
            _EnterEvadeMode();
            HandleDoor();
            Reset();
            Cleanup();
            me->AddAura(SPELL_BASE_VISUAL, me);
            me->AddAura(SPELL_BURNING_WOUNDS_AURA, me);
            me->GetMotionMaster()->MoveTargetedHome();
        }

        void IsSummonedBy(Unit* /*summoner*/)
        {
            events.SetPhase(PHASE_INTRO);
            events.ScheduleEvent(EVENT_INTRO, 5500, 0, PHASE_INTRO);
            me->setActive(true);
            me->PlayOneShotAnimKit(ANIM_KIT_EMERGE);
            SetCombatMovement(false);
            Position pos;
            pos.Relocate(me);
            me->SetHomePosition(pos);
        }

        void KilledUnit(Unit* killed)
        {
            if (killed->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustSummoned(Creature* summon)
        {
            switch (summon->GetEntry())
            {
                case NPC_SULFURAS_SMASH_TARGET:
                    summon->AddAura(SPELL_LAVA_POOL, summon);
                    break;
                case NPC_SON_OF_FLAME:
                    summon->SetReactState(REACT_PASSIVE);
                    summon->AddAura(SPELL_HIT_ME, summon);
                    summon->AddAura(SPELL_PRE_VISUAL, summon);
                    summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                    break;
                default:
                    break;
            }
        }

        void HandleDoor() // Needed because the instancescript needs db guids
        {
            if (GameObject* door = me->FindNearestGameObject(GO_RAGNAROS_DOOR, 200.0f))
            {
                if (door->GetGoState() == GO_STATE_ACTIVE)
                    door->SetGoState(GO_STATE_READY);
                else
                    door->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void Cleanup()
        {
            std::list<Creature*> units;

            GetCreatureListWithEntryInGrid(units, me, NPC_SULFURAS_SMASH_TARGET, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_MAGMA_TRAP, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_LAVA_WAVE, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_SULFURAS_HAND_OF_RAGNAROS, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_SPLITTING_BLOW_TRIGGER, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_SON_OF_FLAME, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_LAVA_SCION, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_ENGULFING_FLAMES_TRIGGER, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_BLAZING_HEAT, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_LIVING_METEOR, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_BLAZING_HEAT, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();
        }

        void CleanSubmerge()
        {
            std::list<Creature*> units;

            GetCreatureListWithEntryInGrid(units, me, NPC_SULFURAS_HAND_OF_RAGNAROS, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            GetCreatureListWithEntryInGrid(units, me, NPC_SPLITTING_BLOW_TRIGGER, 200.0f);
            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                (*itr)->DespawnOrUnsummon();
        }

        void DamageTaken(Unit* attacker, uint32& damage)
        {
            if (me->HealthBelowPct(70) && _submergeCounter == 0)
            {
                _submergeCounter++;

                std::list<Creature*> units;
                GetCreatureListWithEntryInGrid(units, me, NPC_SULFURAS_SMASH_TARGET, 200.0f);
                for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                    (*itr)->DespawnOrUnsummon();

                events.SetPhase(PHASE_SUBMERGED);
                events.ScheduleEvent(EVENT_SPLITTING_BLOW, 1, 0, PHASE_SUBMERGED);
            }
            else if (me->HealthBelowPct(40) && _submergeCounter == 1)
            {
                _submergeCounter++;

                std::list<Creature*> units;
                GetCreatureListWithEntryInGrid(units, me, NPC_SULFURAS_SMASH_TARGET, 200.0f);
                for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                    (*itr)->DespawnOrUnsummon();

                events.SetPhase(PHASE_SUBMERGED);
                events.ScheduleEvent(EVENT_SPLITTING_BLOW, 1, 0, PHASE_SUBMERGED);
            }
            else if (me->HealthBelowPct(10) && _submergeCounter == 2)
            {
                me->Kill(me);
            }
        }

        void DoAction(int32 action)
        {
            switch (action)
            {
                case ACTION_SON_KILLED:
                {
                    _sonCounter++;
                    if (_sonCounter == 8)
                    {
                        DoAction(ACTION_INSTANT_EMERGE);
                        _sonCounter = 0;
                    }
                    break;
                }
                case ACTION_INSTANT_EMERGE:
                    events.CancelEvent(EVENT_ANNOUNCE_EMERGE);
                    events.CancelEvent(EVENT_EMERGE);
                    events.ScheduleEvent(EVENT_EMERGE, 1000);
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!(events.IsInPhase(PHASE_INTRO)))
                if (!UpdateVictim())
                    return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_INTRO:
                        Talk(SAY_ARRIVE);
                        me->AddAura(SPELL_BASE_VISUAL, me);
                        me->AddAura(SPELL_BURNING_WOUNDS_AURA, me);
                        me->PlayOneShotAnimKit(ANIM_KIT_TAUNT);
                        break;
                    case EVENT_ATTACK:
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->Attack(me->getVictim(), false);
                        me->AddAura(SPELL_BASE_VISUAL, me);
                        me->AddAura(SPELL_BURNING_WOUNDS_AURA, me);
                        break;
                    case EVENT_SULFURAS_SMASH_TRIGGER:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0, true, 0))
                        {
                            me->SetFacingToObject(target);
                            DoCast(SPELL_SULFURAS_SMASH_DUMMY);
                            events.ScheduleEvent(EVENT_SULFURAS_SMASH, 500);
                            if (events.IsInPhase(PHASE_1))
                                events.ScheduleEvent(EVENT_SULFURAS_SMASH_TRIGGER, 30000, 0, PHASE_1);
                            else if (events.IsInPhase(PHASE_2))
                                events.ScheduleEvent(EVENT_SULFURAS_SMASH_TRIGGER, 47000, 0, PHASE_2);
                            else if (events.IsInPhase(PHASE_3))
                                events.ScheduleEvent(EVENT_SULFURAS_SMASH_TRIGGER, 47000, 0, PHASE_3);
                        }
                        break;
                    case EVENT_SULFURAS_SMASH:
                        if (Unit* trigger = me->FindNearestCreature(NPC_SULFURAS_SMASH_TRIGGER, 60.0f, true))
                        {
                            Talk(SAY_SULFURAS_SMASH);
                            me->AttackStop();
                            me->SetReactState(REACT_PASSIVE);
                            me->SetFacingToObject(trigger);
                            DoCast(SPELL_SULFURAS_SMASH);
                            DoCast(SPELL_SULFURAS_SMASH_TARGET);
                            events.ScheduleEvent(EVENT_ATTACK, 6000);
                        }
                        break;
                    case EVENT_MAGMA_TRAP:
                        Talk(SAY_MAGMA_TRAP);
                        if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0))
                            DoCast(target, SPELL_MAGMA_TRAP);
                        events.ScheduleEvent(EVENT_MAGMA_TRAP, 25000, 0, PHASE_1);
                        break;
                    case EVENT_WRATH_OF_RAGNAROS:
                        DoCastAOE(SPELL_WRATH_OF_RAGNAROS);
                        events.ScheduleEvent(EVENT_WRATH_OF_RAGNAROS, 36000, 0, PHASE_1);
                        break;
                    case EVENT_HAND_OF_RAGNAROS:
                        DoCastAOE(SPELL_HAND_OF_RAGNAROS);
                        events.ScheduleEvent(EVENT_HAND_OF_RAGNAROS, 25000, 0, PHASE_1);
                        break;
                    case EVENT_SPLITTING_BLOW:
                        events.ScheduleEvent(EVENT_CALL_SONS, 10000, 0, PHASE_SUBMERGED);
                        me->CastStop();
                        me->AttackStop();
                        me->SetReactState(REACT_PASSIVE);
                        Talk(SAY_ANNOUNCE_SPLIT);
                        Talk(SAY_HAMMER_DROP);
                        DoCast(SPELL_SUBMERGE);
                        switch (urand(0, 2))
                        {
                            case 0: // Splitting Blow East
                            {
                                if (Creature* trigger = me->SummonCreature(NPC_SPLITTING_BLOW_TRIGGER, SplittingTriggerEast, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    me->SetFacingToObject(trigger);
                                    DoCastAOE(SPELL_SPLITTING_BLOW_EAST);

                                    for (uint32 x = 0; x<8; ++x)
                                        me->SummonCreature(NPC_SON_OF_FLAME, SonsOfFlameEast[x], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                                }
                                break;
                            }
                            case 1: // Splitting Blow West
                            {
                                if (Creature* trigger = me->SummonCreature(NPC_SPLITTING_BLOW_TRIGGER, SplittingTriggerWest, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    me->SetFacingToObject(trigger);
                                    DoCastAOE(SPELL_SPLITTING_BLOW_WEST);

                                    for (uint32 x = 0; x<8; ++x)
                                        me->SummonCreature(NPC_SON_OF_FLAME, SonsOfFlameWest[x], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                                }
                                break;
                            }
                            case 2: // Splitting Blow North
                            {
                                if (Creature* trigger = me->SummonCreature(NPC_SPLITTING_BLOW_TRIGGER, SplittingTriggerNorth, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    me->SetFacingToObject(trigger);
                                    DoCastAOE(SPELL_SPLITTING_BLOW_NORTH);

                                    for (uint32 x = 0; x<8; ++x)
                                        me->SummonCreature(NPC_SON_OF_FLAME, SonsOfFlameNorth[x], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                                }
                                break;
                            }
                        }
                        break;
                    case EVENT_CALL_SONS:
                        Talk(SAY_SONS_OF_FLAME);
                        me->RemoveAurasDueToSpell(SPELL_BASE_VISUAL);
                        events.ScheduleEvent(EVENT_ANNOUNCE_EMERGE, 33000, 0, PHASE_SUBMERGED);
                        events.ScheduleEvent(EVENT_EMERGE, 40000, 0, PHASE_SUBMERGED);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                        if (_submergeCounter == 2)
                            for (uint32 x = 0; x<2; ++x)
                                me->SummonCreature(NPC_LAVA_SCION, LavaScionPos[x], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
                        break;
                    case EVENT_ANNOUNCE_EMERGE:
                        Talk(SAY_ANNOUNCE_EMERGE);
                        break;
                    case EVENT_EMERGE:
                        Talk(SAY_HAMMER_PICKUP);
                        CleanSubmerge();
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                        me->RemoveAurasDueToSpell(SPELL_SUBMERGE_AURA);
                        me->PlayOneShotAnimKit(ANIM_KIT_RESURFACE);
                        events.ScheduleEvent(EVENT_ATTACK, 4500);
                        if (_submergeCounter == 1)
                        {
                            events.SetPhase(PHASE_2);
                            events.ScheduleEvent(EVENT_SULFURAS_SMASH_TRIGGER, 6000, 0, PHASE_2); // Why the fuck so soon ? o.O
                            events.ScheduleEvent(EVENT_ENGULFING_FLAMES, 40000, 0, PHASE_2);
                            events.ScheduleEvent(EVENT_MOLTEN_SEED, 11000, 0, PHASE_2);
                        }
                        if (_submergeCounter == 2)
                        {
                            events.SetPhase(PHASE_3);
                            events.ScheduleEvent(EVENT_SULFURAS_SMASH_TRIGGER, 6000, 0, PHASE_3);
                            events.ScheduleEvent(EVENT_ENGULFING_FLAMES, 30000, 0, PHASE_3);
                            events.ScheduleEvent(EVENT_LIVING_METEOR, 45000, 0, PHASE_3);
                        }
                        break;
                    case EVENT_ENGULFING_FLAMES:
                        switch (urand(0, 2))
                        {
                            case 0: // Melee
                                {
                                    for (uint32 x = 0; x<16; ++x)
                                        me->SummonCreature(NPC_ENGULFING_FLAMES_TRIGGER, EngulfingFlamesMelee[x], TEMPSUMMON_TIMED_DESPAWN, 20000);
                                    DoCastAOE(SPELL_ENGULFING_FLAMES_VISUAL_MELEE);
                                    DoCastAOE(SPELL_ENGULFING_FLAMES_MELEE);
                                    break;
                                }
                            case 1: // Range
                                {
                                    for (uint32 x = 0; x<19; ++x)
                                        me->SummonCreature(NPC_ENGULFING_FLAMES_TRIGGER, EngulfingFlamesRange[x], TEMPSUMMON_TIMED_DESPAWN, 20000);
                                    DoCastAOE(SPELL_ENGULFING_FLAMES_VISUAL_BOTTOM);
                                    DoCastAOE(SPELL_ENGULFING_FLAMES_BOTTOM);
                                    break;
                                }
                            case 2: // Center
                                {
                                    for (uint32 x = 0; x<36; ++x)
                                        me->SummonCreature(NPC_ENGULFING_FLAMES_TRIGGER, EngulfingFlamesCenter[x], TEMPSUMMON_TIMED_DESPAWN, 20000);
                                    DoCastAOE(SPELL_ENGULFING_FLAMES_VISUAL_CENTER);
                                    DoCastAOE(SPELL_ENGULFING_FLAMES_CENTER);
                                    break;
                                }
                                break;
                        }
                        if (_submergeCounter == 1)
                            events.ScheduleEvent(EVENT_ENGULFING_FLAMES, 40000, 0, PHASE_2);
                        else if (_submergeCounter == 2)
                            events.ScheduleEvent(EVENT_ENGULFING_FLAMES, 30000, 0, PHASE_3);
                        break;
                    case EVENT_MOLTEN_SEED:
                        DoCastAOE(SPELL_MOLTEN_SEED);
                        events.ScheduleEvent(EVENT_MOLTEN_SEED, 30000, 0, PHASE_2);
                        break;
                    case EVENT_LIVING_METEOR:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0, true, 0))
                            DoCast(target, SPELL_LIVING_METEOR_MISSILE);
                        events.ScheduleEvent(EVENT_LIVING_METEOR, 55000, 0, PHASE_3);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_ragnaros_cataAI(creature);
    }
};

class npc_magma_trap : public CreatureScript
{
    public:
        npc_magma_trap() :  CreatureScript("npc_magma_trap") { }

        struct npc_magma_trapAI : public ScriptedAI
        {
            npc_magma_trapAI(Creature* creature) : ScriptedAI(creature)
            {
                _exploded = false;
            }

            bool _exploded;

            void IsSummonedBy(Unit* /*summoner*/)
            {
                events.ScheduleEvent(EVENT_PREPARE_TRAP, 5000);
                me->AddAura(SPELL_MAGMA_TRAP_VISUAL, me);
                me->SetReactState(REACT_PASSIVE);
                SetCombatMovement(false);
            }

            void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell)
            {
                if (spell->Id == SPELL_MAGMA_TRAP_PERIODIC_TICK && !_exploded)
                {
                    DoCastAOE(SPELL_MAGMA_TRAP_ERUPTION);
                    me->RemoveAurasDueToSpell(SPELL_MAGMA_TRAP_VISUAL);
                    _exploded = true;
                    me->DespawnOrUnsummon(3000);
                }
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_PREPARE_TRAP:
                            DoCast(SPELL_MAGMA_TRAP_PERIODIC);
                            break;
                        default:
                            break;
                    }
                }
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_magma_trapAI(creature);
        }
};

class npc_sulfuras_smash : public CreatureScript
{
    public:
        npc_sulfuras_smash() :  CreatureScript("npc_sulfuras_smash") { }

        struct npc_sulfuras_smashAI : public ScriptedAI
        {
            npc_sulfuras_smashAI(Creature* creature) : ScriptedAI(creature)
            {
                _summonCounter = 0;
            }

            uint8 _summonCounter;

            void IsSummonedBy(Unit* summoner)
            {
                events.ScheduleEvent(EVENT_SCORCH, 3400);
                events.ScheduleEvent(EVENT_SUMMON_WAVE_1, 3400);
                me->SetOrientation(summoner->GetOrientation());
                me->setFaction(summoner->getFaction());
            }

            void JustSummoned(Creature* summon)
            {
                summon->setFaction(me->getFaction());
                _summonCounter++;
                if (_summonCounter == 2)
                    summon->SetOrientation(me->GetOrientation() + M_PI/2);
                else if (_summonCounter == 3)
                {
                    summon->SetOrientation(me->GetOrientation() - M_PI/2);
                    _summonCounter = 0;
                }
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SCORCH:
                            me->RemoveAurasDueToSpell(SPELL_LAVA_POOL);
                            me->AddAura(SPELL_SCORCHED_GROUND, me);
                            break;
                        case EVENT_SUMMON_WAVE_1:
                            DoCastAOE(SPELL_LAVA_WAVE_DUMMY_NORTH);
                            events.ScheduleEvent(EVENT_SUMMON_WAVE_2, 50);
                            break;
                        case EVENT_SUMMON_WAVE_2:
                            DoCastAOE(SPELL_LAVA_WAVE_DUMMY_WEST);
                            events.ScheduleEvent(EVENT_SUMMON_WAVE_3, 50);
                            break;
                        case EVENT_SUMMON_WAVE_3:
                            DoCastAOE(SPELL_LAVA_WAVE_DUMMY_EAST);
                            break;
                        default:
                            break;
                    }
                }
            }
    private:
        EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_sulfuras_smashAI(creature);
        }
};

class npc_fl_lava_wave : public CreatureScript
{
    public:
        npc_fl_lava_wave() :  CreatureScript("npc_fl_lava_wave") { }

        struct npc_fl_lava_waveAI : public ScriptedAI
        {
            npc_fl_lava_waveAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void IsSummonedBy(Unit* summoner)
            {
                events.ScheduleEvent(EVENT_MOVE_LAVA_WAVE, 100);
                me->SetSpeed(MOVE_RUN, 2.0f);
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_MOVE_LAVA_WAVE:
                            DoCast(SPELL_LAVA_WAVE);
                            me->GetMotionMaster()->MovePoint(0, me->GetPositionX()+cos(me->GetOrientation())*100, me->GetPositionY()+sin(me->GetOrientation())*100, me->GetPositionZ(), false);
                            break;
                        default:
                            break;
                    }
                }
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_fl_lava_waveAI(creature);
        }
};

class npc_sulfuras_hammer : public CreatureScript // Temphack until dest area effects can affect npc's
{
    public:
        npc_sulfuras_hammer() :  CreatureScript("npc_sulfuras_hammer") { }

        struct npc_sulfuras_hammerAI : public ScriptedAI
        {
            npc_sulfuras_hammerAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            EventMap events;

            void IsSummonedBy(Unit* /*summoner*/)
            {
                me->AddAura(SPELL_SULFURAS_AURA, me);
                DoCastAOE(SPELL_INVOKE_SONS);
                events.ScheduleEvent(EVENT_CHECK_SONS, 500);
            }

            void SpellHitTarget(Unit* target, SpellInfo const* spell)
            {
                if (spell->Id == SPELL_INVOKE_SONS_TRIGGERED_SPELL && target->GetEntry() == NPC_SON_OF_FLAME)
                {
                    if (Creature* son = target->ToCreature())
                        son->AI()->DoAction(ACTION_ACTIVATE_SON);
                }
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_CHECK_SONS:
                        {
                            std::list<Creature*> units;
                            GetCreatureListWithEntryInGrid(units, me, NPC_SON_OF_FLAME, 5.0f);
                            for (std::list<Creature*>::iterator itr = units.begin(); itr != units.end(); ++itr)
                            {
                                if ((*itr)->HasAura(SPELL_HIT_ME))
                                {
                                    (*itr)->RemoveAurasDueToSpell(SPELL_HIT_ME);
                                    (*itr)->StopMoving();
                                    (*itr)->CastSpell((*itr), SPELL_SUPERNOVA);
                                    me->Kill((*itr), false);
                                }
                            }
                            events.ScheduleEvent(EVENT_CHECK_SONS, 500);
                            break;
                        }
                        default:
                            break;
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_sulfuras_hammerAI(creature);
        }
};

class npc_son_of_flame : public CreatureScript
{
    public:
        npc_son_of_flame() :  CreatureScript("npc_son_of_flame") { }

        struct npc_son_of_flameAI : public ScriptedAI
        {
            npc_son_of_flameAI(Creature* creature) : ScriptedAI(creature),
                instance(creature->GetInstanceScript())
            {
            }

            InstanceScript* instance;
            EventMap events;

            void JustDied(Unit* /*killer*/)
            {
                if (Creature* ragnaros = me->FindNearestCreature(BOSS_RAGNAROS, 200.0f, true))
                    ragnaros->AI()->DoAction(ACTION_SON_KILLED);
            }

            void DamageTaken(Unit* /*damager*/, uint32& damage)
            {
                if (me->HealthBelowPct(95))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 9);
                else if (me->HealthBelowPct(90))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 8);
                else if (me->HealthBelowPct(85))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 7);
                else if (me->HealthBelowPct(80))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 6);
                else if (me->HealthBelowPct(75))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 5);
                else if (me->HealthBelowPct(70))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 4);
                else if (me->HealthBelowPct(65))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 3);
                else if (me->HealthBelowPct(60))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 2);
                else if (me->HealthBelowPct(55))
                    me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 1);
                else if (me->HealthBelowPct(50))
                {
                    me->RemoveAurasDueToSpell(SPELL_BURNING_SPEED_STACKS);
                    me->RemoveAurasDueToSpell(SPELL_BURNING_SPEED);
                }
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_ACTIVATE_SON:
                        me->RemoveAurasDueToSpell(SPELL_PRE_VISUAL);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                        me->AddAura(SPELL_BURNING_SPEED, me);
                        me->AddAura(SPELL_BURNING_SPEED_STACKS, me);
                        me->SetAuraStack(SPELL_BURNING_SPEED_STACKS, me, 10);
                        me->PlayOneShotAnimKit(ANIM_KIT_UNK_1);
                        if (Creature* sulfuras = me->FindNearestCreature(NPC_SULFURAS_HAND_OF_RAGNAROS, 200.0f))
                            me->GetMotionMaster()->MovePoint(0, sulfuras->GetPositionX(), sulfuras->GetPositionY(), sulfuras->GetPositionZ());
                        events.ScheduleEvent(EVENT_MOVE_HAMMER, 1000);
                        break;
                    default:
                        break;
                }
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_MOVE_HAMMER:
                            if (Creature* sulfuras = me->FindNearestCreature(NPC_SULFURAS_HAND_OF_RAGNAROS, 200.0f))
                                me->GetMotionMaster()->MovePoint(0, sulfuras->GetPositionX(), sulfuras->GetPositionY(), sulfuras->GetPositionZ());
                            events.ScheduleEvent(EVENT_MOVE_HAMMER, 1000);
                            break;
                        default:
                            break;
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_son_of_flameAI(creature);
        }
};

class npc_engulfing_flame : public CreatureScript
{
    public:
        npc_engulfing_flame() :  CreatureScript("npc_engulfing_flame") { }

        struct npc_engulfing_flameAI : public ScriptedAI
        {
            npc_engulfing_flameAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void UpdateAI(uint32 diff)
            {
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_engulfing_flameAI(creature);
        }
};

class npc_fl_molten_elemental : public CreatureScript
{
    public:
        npc_fl_molten_elemental() :  CreatureScript("npc_fl_molten_elemental") { }

        struct npc_fl_molten_elementalAI : public ScriptedAI
        {
            npc_fl_molten_elementalAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void IsSummonedBy(Unit* summoner)
            {
                DoCastAOE(SPELL_INVISIBLE_PRE_VISUAL);
                DoCastAOE(SPELL_MOLTEN_SEED_VISUAL);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                me->SetReactState(REACT_PASSIVE);

                if (Creature* seedCaster = me->FindNearestCreature(NPC_MOLTEN_SEED_CASTER, 100.0f, true))
                    seedCaster->CastSpell(me, SPELL_MOLTEN_SEED_MISSILE);
                events.ScheduleEvent(EVENT_ACTIVATE, 10000);
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_ACTIVATE:
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                            me->SetReactState(REACT_AGGRESSIVE);
                            if (Unit* target = me->FindNearestPlayer(100.0f, true))
                                me->Attack(target, false);
                            break;
                        default:
                            break;
                    }
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                me->DespawnOrUnsummon(5000);
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_fl_molten_elementalAI(creature);
        }
};

class npc_fl_lava_scion : public CreatureScript
{
    public:
        npc_fl_lava_scion() :  CreatureScript("npc_fl_lava_scion") { }

        struct npc_fl_lava_scionAI : public ScriptedAI
        {
            npc_fl_lava_scionAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = me->GetInstanceScript();
            }

            InstanceScript* instance;

            void IsSummonedBy(Unit* summoner)
            {
                if (Unit* player = me->FindNearestPlayer(100.0f, true))
                    me->Attack(player, false);
            }

            void EnterCombat(Unit* /*victim*/)
            {
                instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);
                events.ScheduleEvent(EVENT_BLAZING_HEAT, 12000);
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_BLAZING_HEAT:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0, true, 0))
                                DoCast(target, SPELL_BLAZING_HEAT);
                            events.ScheduleEvent(EVENT_BLAZING_HEAT, 21000);
                            break;
                        default:
                            break;
                    }
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                me->DespawnOrUnsummon(5000);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_fl_lava_scionAI(creature);
        }
};

class npc_fl_blazing_heat : public CreatureScript
{
    public:
        npc_fl_blazing_heat() :  CreatureScript("npc_fl_blazing_heat") { }

        struct npc_fl_blazing_heatAI : public ScriptedAI
        {
            npc_fl_blazing_heatAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void IsSummonedBy(Unit* summoner)
            {
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                DoCastAOE(SPELL_BLAZING_HEAT_DAMAGE_AURA);
            }

            void UpdateAI(uint32 diff)
            {
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_fl_blazing_heatAI(creature);
        }
};

class npc_fl_living_meteor : public CreatureScript
{
    public:
        npc_fl_living_meteor() :  CreatureScript("npc_fl_living_meteor") { }

        struct npc_fl_living_meteorAI : public ScriptedAI
        {
            npc_fl_living_meteorAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void IsSummonedBy(Unit* summoner)
            {
                events.ScheduleEvent(EVENT_STALK_PLAYER, 3000);
                me->SetReactState(REACT_PASSIVE);
                me->SetInCombatWithZone();
            }

            void DamageTaken(Unit* attacker, uint32& damage)
            {
                if (me->HasAura(SPELL_LIVING_METEOR_COMBUSTIBLE))
                {
                    events.Reset();
                    me->RemoveAllAuras();
                    me->GetMotionMaster()->Clear();
                    events.ScheduleEvent(EVENT_STALK_PLAYER, 3000);
                    DoCastAOE(SPELL_LIVING_METEOR_COMBUSTITION);
                }
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_STALK_PLAYER:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0, true, 0))
                            {
                                DoCastAOE(SPELL_LIVING_METEOR_INCREASE_SPEED);
                                DoCastAOE(SPELL_LIVING_METEOR_DAMAGE_REDUCTION);
                                me->CastSpell(target, SPELL_LIVING_METEOR_FIXATE, false);
                                me->ClearUnitState(UNIT_STATE_CASTING);
                                me->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f);
                                events.ScheduleEvent(EVENT_KILL_PLAYER, 1000);
                                events.ScheduleEvent(EVENT_ENABLE_KNOCKBACK, 2000);
                            }
                            break;
                        case EVENT_KILL_PLAYER:
                            if (Unit* player = me->FindNearestPlayer(5.0f, true))
                            {
                                events.Reset();
                                me->RemoveAllAuras();
                                me->GetMotionMaster()->Clear();
                                events.ScheduleEvent(EVENT_STALK_PLAYER, 3000);
                                DoCastAOE(SPELL_LIVING_METEOR_EXPLOSION);
                            }
                            else
                                events.ScheduleEvent(EVENT_KILL_PLAYER, 1000);
                            break;
                        case EVENT_ENABLE_KNOCKBACK:
                            DoCastAOE(SPELL_LIVING_METEOR_COMBUSTIBLE);
                            break;
                        default:
                            break;
                    }
                }
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_fl_living_meteorAI(creature);
        }
};

class spell_splitting_blow : public SpellScriptLoader
{
public:
    spell_splitting_blow() : SpellScriptLoader("spell_fl_splitting_blow") { }

    class spell_splitting_blow_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_splitting_blow_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            GetHitUnit()->CastSpell(GetHitUnit(), 99056);
            GetHitUnit()->CastSpell(GetHitUnit(), 99014);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_splitting_blow_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_splitting_blow_SpellScript();
    }
};

class spell_invoke_sons : public SpellScriptLoader
{
public:
    spell_invoke_sons() : SpellScriptLoader("spell_fl_invoke_sons") { }

    class spell_invoke_sons_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_invoke_sons_SpellScript);

        bool Validate(SpellInfo const* spellEntry)
        {
            if (!sSpellMgr->GetSpellInfo(99054))
                return false;
            return true;
        }

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            GetCaster()->CastSpell(GetHitUnit(), 99050, true);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_invoke_sons_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_invoke_sons_SpellScript();
    }
};

class spell_fl_blazing_heat : public SpellScriptLoader
{
    public:
        spell_fl_blazing_heat() :  SpellScriptLoader("spell_fl_blazing_heat") { }

        class spell_fl_blazing_heat_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_fl_blazing_heat_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_BLAZING_HEAT_AURA))
                    return false;
                return true;
            }

            void OnPeriodic(AuraEffect const* /*aurEff*/)
            {
                GetTarget()->CastSpell(GetTarget(), SPELL_BLAZING_HEAT_SUMMON, false);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_fl_blazing_heat_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_fl_blazing_heat_AuraScript();
        }
};


void AddSC_boss_ragnaros_cata()
{
    new at_sulfuron_keep();
    new boss_ragnaros_cata();
    new npc_magma_trap();
    new npc_sulfuras_smash();
    new npc_fl_lava_wave();
    new npc_sulfuras_hammer();
    new npc_son_of_flame();
    new npc_engulfing_flame();
    new npc_fl_molten_elemental();
    new npc_fl_lava_scion();
    new npc_fl_blazing_heat();
    new npc_fl_living_meteor();
    new spell_splitting_blow();
    new spell_invoke_sons();
    new spell_fl_blazing_heat();
}