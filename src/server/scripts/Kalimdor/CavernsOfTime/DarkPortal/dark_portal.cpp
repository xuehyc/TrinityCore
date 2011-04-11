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

#include "ScriptPCH.h"
#include "dark_portal.h"
#include "WorldPacket.h"

#define SAY_INTRO           "The time has come! Gul'dan, order your warlocks to double their efforts! Moments from now the gateway will open, and your Horde will be released upon this ripe, unsuspecting world!"
#define SOUND_INTRO         10435
#define SAY_WEAK75          "Champions, my shield grows weak!"
#define SOUND_WEAK75        10437
#define SAY_WEAK50          "My powers must be concentrated on the portal! I do not have time to hold the shield!"
#define SOUND_WEAK50        10438
#define SAY_WEAK25          "The shield is nearly gone! All that I have worked for is in danger!"
#define SOUND_WEAK25        10439
#define SAY_COMPLETE        "I am grateful for your aid, champions. Now, Gul'dan's Horde will sweep across this world, like a locust swarm, and all my designs, all my carefully laid plans will at last fall into place."
#define SOUND_COMPLETE      10440
#define SAY_DEATH           "No... damn this feeble mortal coil..."
#define SOUND_DEATH         10441
//#define SAY_HELLO           "What is this? Champions, coming to my aid? I sense the hand of the dark one in this. Truly this sacred event bears his blessing?"
//#define SOUND_HELLO         10436

#define MOB_GROUND_RUNES                18562
#define SPELL_EFFEKT_GROUND_RUNES       32570
#define SPELL_SHIELD_EFFEKT             31635
#define SPELL_MEDIVH_CHANNEL            31556

#define BOSS_CHRONO_LORD_DEJA           17879
#define BOSS_TEMPORUS                   17880
#define H_MOB_TIMEREAVER                21698 //Temporus Double
#define H_MOB_CHRONO_LORD               21697 //Deja Double
#define BOSS_AEONUS                     17881

#define MOB_TIME_RIFT                   17838

#define MOB_RIFT_KEEPER                 21104
#define MOB_RIFT_LORD                   17839

#define MOB_INFINITE_WHELP              21818
#define MOB_INFINITE_ASSASSIN           17835
#define MOB_INFINITE_CHRONOMANCER       17892
#define MOB_INFINITE_EXECUTIONER        18994
#define MOB_INFINITE_VANQUISHER         18995

static float RiftLocations[4][3]=
{
    {-1954.875f, 7199.664f, 22.361f},
    {-1884.577f, 7105.649f, 22.641f},
    {-1953.659f, 7013.159f, 22.436f},
    {-2036.578f, 7024.884f, 23.153f},
};

class npc_medivh_bm : public CreatureScript
{
public:
    npc_medivh_bm() : CreatureScript("npc_medivh_bm") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_medivhAI (pCreature);
    }

    struct  mob_medivhAI : public ScriptedAI
    {
        mob_medivhAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            Runes_GUID = 0;
        }

        InstanceScript *pInstance;

        uint32 Wave_Timer;
        uint32 Phase;
        uint64 Portal_GUID;
        uint64 Runes_GUID;
        uint32 Control;
        bool Has75hp;
        bool Has50hp;
        bool Has25hp;
        bool Finished;

        void Reset()
        {
            Wave_Timer = 0;
            Phase = 0;
            Control = rand()%4;
            Has75hp = false;
            Has50hp = false;
            Has25hp = false;
            Finished = false;
            me->setActive(true);

            if (pInstance)
            {
                pInstance->SetData(DATA_WAVE, 0);
                pInstance->SetData(DATA_MEDIVHDEATH, 0);
                pInstance->SetData(DATA_SHIELDPERCENT, 100);

                if(pInstance->GetData(DATA_AEONUSDEATH) == 1)
                {
                    pInstance->SetData(DATA_WAVE, 18);
                    me->MonsterYell(SAY_COMPLETE, LANG_UNIVERSAL, 0);
                    me->RemoveAurasDueToSpell(31556);
                    me->CombatStop();
                    me->SetUInt32Value(UNIT_NPC_FLAGS,3); // Can finished quest
                    Finished = true;
                }
            }

            Creature* Runes = (Creature*)Unit::GetUnit((*me),Runes_GUID);
            if(!Runes)
            {        
                Runes = DoSpawnCreature(MOB_GROUND_RUNES,0,0,0,0,TEMPSUMMON_CORPSE_DESPAWN,10000);
                Runes->CastSpell(Runes,SPELL_EFFEKT_GROUND_RUNES,false);
                Runes_GUID = Runes->GetGUID();
            }

            DoCast(me,SPELL_SHIELD_EFFEKT,true);
            DoCast(me,SPELL_MEDIVH_CHANNEL);

            me->SetUInt32Value(UNIT_NPC_FLAGS,0);
        }

        void UpdateWorldState(uint32 field, uint32 value)
        {
            Map * map = me->GetMap();
            if(!map->IsDungeon()) return;

            WorldPacket data(SMSG_UPDATE_WORLD_STATE, 8);

            data << field;
            data << value;

            ((InstanceMap*)map)->SendToPlayers(&data);

            // TODO: Uncomment and remove everything above this line only when the core patch for this is accepted
            //me->GetMap()->UpdateWorldState(field, value);
        }

        void EnterCombat(Unit *who){}

        void StartEvent()
        {
            me->MonsterYell(SAY_INTRO, LANG_UNIVERSAL, 0);
            DoPlaySoundToSet(me, SOUND_INTRO);
        
            Phase = 1;
        }

        /** Begin event when player is 10m arround Medivh **/
        void MoveInLineOfSight(Unit *who)
        {
            if (!who || me->getVictim())
                return;

            if(who->isAlive() && (who->GetTypeId() == TYPEID_PLAYER))
            {
                if (Phase == 0)
                {
                    //Show Interface
                    UpdateWorldState(2541, 1);
                    //Set up percent...
                    UpdateWorldState(2540, 100);
                    //... and waves
                    UpdateWorldState(2784, 0);

                    if(me->IsWithinDistInMap(who, 20.0f))
                        StartEvent();
                }
            }
        }

        void SummonPortalRandomPosition(uint32 cas)
        {
            Creature* Portal;
            Portal = me->SummonCreature(MOB_TIME_RIFT,RiftLocations[cas][0],RiftLocations[cas][1],RiftLocations[cas][2], 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
        
            //m�sste verbessert werden (auch wenn gering ... unendlichkeit ist gegeben)
            do
            {
                Control = rand()%4;
            } while (Control == cas);
            Portal->setActive(true);
            Portal_GUID = Portal->GetGUID();
        }

        void JustDied(Unit* Killer)
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_MEDIVHDEATH, 1);
                pInstance->SetData(DATA_SHIELDPERCENT, 0);
            }

            //me->GetMap()->UpdateWorldState(2541, 0);
            UpdateWorldState(2541, 0);

            me->MonsterYell(SAY_DEATH, LANG_UNIVERSAL, 0);
            DoPlaySoundToSet(me, SOUND_DEATH);
        }

        void UpdateAI(const uint32 diff)
        {
            if (Phase == 0 || pInstance->GetData(DATA_MEDIVHDEATH) == 1)
                return;

            if (Phase == 1)
            {
                Unit* Portal_control;
                Portal_control =  Unit::GetUnit((*me),Portal_GUID);
                switch(pInstance->GetData(DATA_WAVE))
                {
                    // 1st wave
                    case 0:
                        if(Wave_Timer < diff)
                        {
                            pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                            SummonPortalRandomPosition(Control);
                            Wave_Timer = 125000;
                            //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                        }else Wave_Timer -= diff;
                        break;
                    // 1st wave
                    case 1: case 2: case 3: case 4:
                        if(Wave_Timer < diff || (!Portal_control || Portal_control->isDead()))
                        {
                            pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                            SummonPortalRandomPosition(Control);
                            Wave_Timer = 125000;
                            //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                        }else Wave_Timer -= diff;
                        break;
                    // Spawn Chrono Lord Deja
                    case 5:
                        if(Wave_Timer < diff || (!Portal_control || Portal_control->isDead()))
                        {
                            pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                            SummonPortalRandomPosition(Control);
                            Wave_Timer = 125000; //was 240.000
                            //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                        }else Wave_Timer -= diff;
                        break;
                    // 2nd wave, first portal after Chrono Lord Deja's death shouldn't be spawned instant
                    case 6:
                        if(!Portal_control || (Portal_control && Portal_control->isDead()))
                        {
                            if (Wave_Timer < diff)
                            {
                                pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                                SummonPortalRandomPosition(Control);
                                Wave_Timer = 125000;
                                //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                                UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            }else Wave_Timer -= diff;
                        }
                        break;
                    // 2nd wave, all other waves should
                    case 7: case 8: case 9: case 10:
                        if(Wave_Timer < diff || (!Portal_control || Portal_control->isDead()))
                        {
                            pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                            SummonPortalRandomPosition(Control);
                            Wave_Timer = 125000;
                            //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                        }else Wave_Timer -= diff;
                        break;
                    // Spawn Temporus
                    case 11:
                        if(Wave_Timer < diff || (!Portal_control || Portal_control->isDead()) )
                        {
                                pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                                SummonPortalRandomPosition(Control);
                                Wave_Timer = 125000; //was 220.000
                                //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                                UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                        }else Wave_Timer -= diff;
                        break;
                    // 3rd wave, first portal after Temporus's death shouldn't be spawned instant
                    case 12:
                        if(!Portal_control || Portal_control->isDead())
                        {
                            if (Wave_Timer < diff)
                            {
                                pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                                SummonPortalRandomPosition(Control);
                                Wave_Timer = 125000;
                                //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                                UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            }else Wave_Timer -= diff;
                        }
                        break;
                    // 3rd wave, all other should
                    case 13: case 14: case 15: case 16:
                        if(Wave_Timer < diff || (!Portal_control || Portal_control->isDead()))
                        {
                            pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                            SummonPortalRandomPosition(Control);
                            Wave_Timer = 125000;
                            //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                        }else Wave_Timer -= diff;
                        break;
                    // Spawn Aeonus
                    case 17:
                        if(Wave_Timer < diff || (!Portal_control || Portal_control->isDead()))
                        {
                            pInstance->SetData(DATA_WAVE, pInstance->GetData(DATA_WAVE)+1);
                            SummonPortalRandomPosition(Control);
                            //me->GetMap()->UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            UpdateWorldState(2784, pInstance->GetData(DATA_WAVE));
                            Wave_Timer = 125000;
                            Phase = 2;
                        }else Wave_Timer -= diff;
                        break;
                }
            }else{
                if(pInstance->GetData(DATA_AEONUSDEATH) == 1)
                {
                    if(!Finished)
                    {
                        me->MonsterYell(SAY_COMPLETE, LANG_UNIVERSAL, 0);
                        DoPlaySoundToSet(me, SOUND_COMPLETE);
                        me->RemoveAurasDueToSpell(31556);
                        me->InterruptNonMeleeSpells(false);
                        me->CombatStop();
                        me->SetUInt32Value(UNIT_NPC_FLAGS,3); // Can finished quest
                        Finished = true;

                        Map *map = me->GetMap();
                        if(map->IsDungeon())
                        {
                            InstanceMap::PlayerList const &PlayerList = ((InstanceMap*)map)->GetPlayers();
                            for (InstanceMap::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            {
                                if (Player* i_pl = i->getSource())
                                {
                                    if(i_pl->GetQuestStatus(10297) == QUEST_STATUS_INCOMPLETE)
                                        i_pl->CompleteQuest(10297);
                                    if(i_pl->GetQuestStatus(9836) == QUEST_STATUS_INCOMPLETE)
                                        i_pl->CompleteQuest(9836);
                                }
                            }
                        }
                    }
                }
            }

            /** Medivh yells every 25% **/
            if (!Has75hp){
                if ( pInstance->GetData(DATA_SHIELDPERCENT) <= 75 )
                {
                    me->MonsterYell(SAY_WEAK75, LANG_UNIVERSAL, 0);
                    DoPlaySoundToSet(me, SOUND_WEAK75);
                    Has75hp = true;
                }
            }else if(!Has50hp){
                if ( pInstance->GetData(DATA_SHIELDPERCENT) <= 50 )
                {
                    me->MonsterYell(SAY_WEAK50, LANG_UNIVERSAL, 0);
                    DoPlaySoundToSet(me, SOUND_WEAK50);
                    Has50hp = true;
                }
            }else if(!Has25hp){
                if ( pInstance->GetData(DATA_SHIELDPERCENT) <= 25 )
                {
                    me->MonsterYell(SAY_WEAK25, LANG_UNIVERSAL, 0);
                    DoPlaySoundToSet(me, SOUND_WEAK25);
                    Has25hp = true;
                }
            }
        }
    };
};

class npc_time_rift : public CreatureScript
{
public:
    npc_time_rift() : CreatureScript("npc_time_rift") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_time_riftAI (pCreature);
    }

    struct  mob_time_riftAI : public ScriptedAI
    {
        mob_time_riftAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            RiftGuardianSpawned = false;
            HeroicMode = me->GetMap()->IsHeroic();
        }

        bool HeroicMode;
        InstanceScript *pInstance;
        uint32 Add_Spawn_Timer;
        bool RiftGuardianSpawned;
        uint32 RiftGuardSpawn_Timer;
        uint32 Control;
        uint64 Guardian_GUID;

        void Reset()
        {
            me->setActive(true);
            Add_Spawn_Timer = rand()%5000;
            RiftGuardSpawn_Timer = 15000;
            Control = 0;
        }

        void EnterCombat(Unit *who){}

        void SummonInfiniteSpawnAdd(uint32 entry)
        {
            Unit *pMedivh = Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH));
            Creature* Infinite_Spawn;

            switch(entry)
            {
            case MOB_INFINITE_ASSASSIN:
                Infinite_Spawn = DoSpawnCreature(MOB_INFINITE_ASSASSIN, 0, 0, 0, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
                break;
            case MOB_INFINITE_WHELP:
                for(int i = 0 ; i < 3 ; i++)
                {
                    Infinite_Spawn = DoSpawnCreature(MOB_INFINITE_WHELP, 0, 0, 0, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
                }
                break;
            case MOB_INFINITE_CHRONOMANCER:
                Infinite_Spawn = DoSpawnCreature(MOB_INFINITE_CHRONOMANCER, 0, 0, 0, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
                break;
            case MOB_INFINITE_EXECUTIONER:
                Infinite_Spawn = DoSpawnCreature(MOB_INFINITE_EXECUTIONER, 0, 0, 0, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
                break;
            case MOB_INFINITE_VANQUISHER:
                Infinite_Spawn = DoSpawnCreature(MOB_INFINITE_VANQUISHER, 0, 0, 0, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
                break;
            }
        }

        uint32 SummonInfiniteSpawn(uint32 cas)
        {
            //During Wave 1 to 6 (including the Boss Chrono Lord Deja) we will have the following repeating cycle:
            //1 Assassin, 3 Whelps, 1 Chronomancer
            if(pInstance->GetData(DATA_WAVE) <= 6)
            {
                switch(cas)
                {
                case 0:
                    //Infinite Assassin
                    SummonInfiniteSpawnAdd(MOB_INFINITE_ASSASSIN);
                    cas++;
                    return cas;
                case 1:
                    //3 Infinite Whelp
                    SummonInfiniteSpawnAdd(MOB_INFINITE_WHELP);
                    cas++;
                    return cas;
                case 2:
                    //Infinite Chronomancer
                    SummonInfiniteSpawnAdd(MOB_INFINITE_CHRONOMANCER);
                    cas = 0;
                    return cas;
                }
            }
            //During Wave 7 to 12 (including the Boss Temporus) we will have the following repeating cycle:
            //1 Executioner, 1 Chronomancer, 3 Whelps, 1 Assassin
            if((pInstance->GetData(DATA_WAVE) >= 7) && (pInstance->GetData(DATA_WAVE) <= 12 ))
            {
                switch(cas)
                {
                case 0:
                    //Infinite Executioner
                    SummonInfiniteSpawnAdd(MOB_INFINITE_EXECUTIONER);
                    cas++;
                    return cas;
                case 1:
                    //Infinite Chronomancer
                    SummonInfiniteSpawnAdd(MOB_INFINITE_CHRONOMANCER);
                    cas++;
                    return cas;
                case 2:
                    //3 Infinite Whelp
                    SummonInfiniteSpawnAdd(MOB_INFINITE_WHELP);
                    cas++;
                    return cas;
                case 3:
                    //Infinite Assassin
                    SummonInfiniteSpawnAdd(MOB_INFINITE_ASSASSIN);
                    cas = 0;
                    return cas;
                }
            }
            //During Wave 13 to 17 (NOT at Wave 18! The Boss Aeonus will spawn alone)
            //we will have the following repeating cycle:
            //1 Executioner, 1 Vanquisher, 1 Chronomancer, 1 Assassin
            if((pInstance->GetData(DATA_WAVE) >= 13) && (pInstance->GetData(DATA_WAVE) <= 17 ))
            {
                switch(cas)
                {
                case 0:
                    //Infinite Executioner
                    SummonInfiniteSpawnAdd(MOB_INFINITE_EXECUTIONER);
                    cas++;
                    return cas;
                case 1:
                    //Infinite Vanquisher
                    SummonInfiniteSpawnAdd(MOB_INFINITE_VANQUISHER);
                    cas++;
                    return cas;
                case 2:
                    //Infinite Chronomancer
                    SummonInfiniteSpawnAdd(MOB_INFINITE_CHRONOMANCER);
                    cas++;
                    return cas;
                case 3:
                    //Infinite Assassin
                    SummonInfiniteSpawnAdd(MOB_INFINITE_ASSASSIN);
                    cas = 0;
                    return cas;
                }
            }
            return 0;
        }

        void SummonRandomGuardian()
        {
            Creature *Guardian;
            Unit *pMedivh = Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH));
            uint32 wave = pInstance->GetData(DATA_WAVE); 
        
            switch (wave)
            {   
            case 6:
                if(HeroicMode)
                {    
                    if( pInstance->GetData(DATA_CHRONOLORDDEJADEATH) == 1) Guardian = DoSpawnCreature(H_MOB_CHRONO_LORD, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                    else Guardian = DoSpawnCreature(BOSS_CHRONO_LORD_DEJA, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 600000);
                }
                else 
                {
                    Guardian = DoSpawnCreature(BOSS_CHRONO_LORD_DEJA, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 600000);
                }
                break;
            case 12:
                if(HeroicMode)
                {
                    if( pInstance->GetData(DATA_TEMPORUSDEATH) == 1) Guardian = DoSpawnCreature(H_MOB_TIMEREAVER, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                    else Guardian = DoSpawnCreature(BOSS_TEMPORUS, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 600000);
                }
                else
                {
                    Guardian = DoSpawnCreature(BOSS_TEMPORUS, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 600000);
                }
                break;
            case 18:
                Guardian = DoSpawnCreature(BOSS_AEONUS, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 600000);
                break;
            default:
                switch(rand()%2)
                {
                case 0:
                    //Rift Keeper
                    Guardian = DoSpawnCreature(MOB_RIFT_KEEPER, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                    break;
                case 1:
                    //Rift Lord
                    Guardian = DoSpawnCreature(MOB_RIFT_LORD, float(rand()%5), float(rand()%5), 0.0f, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                    break;
                }
                break;
            }
            Guardian_GUID = Guardian->GetGUID();
            DoCast(Guardian,31387);
        }

        void UpdateAI(const uint32 diff)
        {   
            Creature* Guardian =  (Creature*)Unit::GetUnit((*me),Guardian_GUID);
            /** Despawn if Medivh dies **/
            if(pInstance->GetData(DATA_MEDIVHDEATH) == 1)
            {
                if(Guardian)
                {
                    if(Guardian->isAlive())
                        Guardian->DealDamage(Guardian, Guardian->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                    Guardian->RemoveCorpse();
                }
                me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                me->RemoveCorpse();
                return;
            }

            if(!RiftGuardianSpawned)
            {
                if(RiftGuardSpawn_Timer < diff)
                {
                    SummonRandomGuardian();
                    RiftGuardianSpawned = true;
                }else RiftGuardSpawn_Timer -= diff;
            }else
            {
                if(Add_Spawn_Timer < diff)
                {
                    Control = SummonInfiniteSpawn(Control);
                    Add_Spawn_Timer = 15000;
                }else Add_Spawn_Timer -= diff;
            }        

            if(Guardian)
            {
                if(!Guardian->isAlive())
                {
                    me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                    me->RemoveCorpse();
                }
            }
        }
    };
};

#define CORRUPT_MEDIVH              31326

//Infinite Assasin
#define BACKSTAB                    7159
#define KIDNEY_SHOT                 30832
#define RUPTURE                     15583 // 14874
#define SINISTER_STRIKE             15667 // 14873

//Infinite Chronomancer
#define ARCANE_BOLT                 15230 // 15124
#define ARCANE_EXPLOSION            33860 // 33623
#define FROST_NOVA                  15531 // 15063
#define FROST_BOLT_CHRONO           15497 // 12675 

//Infinite Executioner
#define CLEAVE                      15496
#define HAMSTRING                   9080
#define OVERPOWER                   37321 // 17198
#define STRIKE                      34920 // 15580

//Rift Keeper
#define BLAST_WAVE                  38536 // 36278 
#define CURSE_OF_VULNERABILITY      36276
#define ENRAGE                      8269
#define FEAR                        12542
#define FROST_BOLT_KEEPER           38534 // 36279
#define POLYMORPH                   13323
#define PYROBLAST                   38535 // 36277
#define SHADOW_BOLT_VALLEY          36275

//Rift Lord
//ENRAGE
//HAMSTRING
#define KNOCKDOWN                   11428
#define MORTAL_STRIKE               35054 // 15708
#define SUNDER_ARMOR                16145
#define THUNDERCLAP                 38537 // 36214

class mobs_infinite_adds : public CreatureScript
{
public:
    mobs_infinite_adds() : CreatureScript("mobs_infinite_adds") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mobs_infinite_addsAI (pCreature);
    }

    struct  mobs_infinite_addsAI : public ScriptedAI
    {
        mobs_infinite_addsAI(Creature *c) : ScriptedAI(c) 
        {
            pInstance = c->GetInstanceScript();
        }

        bool IsChanneling;

        // "Corrupt Medivh" Timer
        uint32 Corrupt_Timer;

        // Infinite Assasin Timers
        uint32 Assasin_Backstab_Timer;
        uint32 Assasin_KidneyShot_Timer;
        uint32 Assasin_Rupture_Timer;
        uint32 Assasin_SinisterStrike_Timer;

        // Infinite Chronomancer Timers
        uint32 Chrono_ArcaneBolt_Timer;
        uint32 Chrono_ArcaneExplosion_Timer;
        uint32 Chrono_FrostNova_Timer;
        uint32 Chrono_FrostBolt_Timer;

        // Infinite Executioner Timers
        uint32 Executioner_Cleave_Timer;
        uint32 Executioner_Hamstring_Timer;
        uint32 Executioner_Overpower_Timer;
        uint32 Executioner_Strike_Timer;

        // Rift Keeper Type + Timers
        uint32 Keeper_Type;
        uint32 Keeper_BlastWave_Timer;
        uint32 Keeper_Curse_Timer;
        uint32 Keeper_Enrage_Timer;
        uint32 Keeper_Fear_Timer;
        uint32 Keeper_FrostBolt_Timer;
        uint32 Keeper_Polymorph_Timer;
        uint32 Keeper_Pyroblast_Timer;
        uint32 Keeper_ShadowBoltValley_Timer;

        // Rift Lord Timers
        uint32 Lord_Enrage_Timer;
        uint32 Lord_Hamstring_Timer;
        uint32 Lord_Knockdown_Timer;
        uint32 Lord_MortalStrike_Timer;
        uint32 Lord_SunderArmor_Timer;
        uint32 Lord_Thunderclap_Timer;

        InstanceScript* pInstance;

        void Reset()
        {
            //me->setActive(true); // cause Crash ... isnt neccesary
            IsChanneling = false;
            // Corrupt Medivh
            Corrupt_Timer = 3000;

            // Infinite Assasin Timers
            Assasin_Backstab_Timer = 9999999; //dunno know
            Assasin_KidneyShot_Timer = 5000;
            Assasin_Rupture_Timer = 3000;
            Assasin_SinisterStrike_Timer = 1000;

            // Infinite Chronomancer Timers
            Chrono_ArcaneBolt_Timer = 5000;
            Chrono_ArcaneExplosion_Timer = 6000+rand()%2000;
            Chrono_FrostNova_Timer = 1000;
            Chrono_FrostBolt_Timer = 2000;

            // Infinite Executioner Timers
            Executioner_Cleave_Timer = 9000;
            Executioner_Hamstring_Timer = 5000;
            Executioner_Overpower_Timer = 7000;
            Executioner_Strike_Timer = 10000;

            // Rift Keeper Type + Timers
            Keeper_Type = rand()%2;
            Keeper_BlastWave_Timer = 9000+rand()%6000;
            Keeper_Curse_Timer = 20000; //dunno know
            Keeper_Enrage_Timer = 120000;
            Keeper_Fear_Timer = 10000;
            Keeper_FrostBolt_Timer = 1000;
            Keeper_Polymorph_Timer = 10000;
            Keeper_Pyroblast_Timer = 4000+rand()%6000;
            Keeper_ShadowBoltValley_Timer = 5000+rand()%2000;

            // Rift Lord Timers
            Lord_Enrage_Timer = 120000;
            Lord_Hamstring_Timer = 30000;
            Lord_Knockdown_Timer = 35000;
            Lord_MortalStrike_Timer = 15000;
            Lord_SunderArmor_Timer = 1000;
            Lord_Thunderclap_Timer = 10000;

            uint32 CreatureID = me->GetEntry();
            if ((CreatureID == 17839 || CreatureID == 21104))
                return;

            Creature *pMedivh = (Creature*)(Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH)));
            if(pMedivh)
            {
                float x,y;
                pMedivh->GetNearPoint2D(x,y,10,pMedivh->GetAngle(me));
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                (*me).GetMotionMaster()->MovePoint(1,x,y,pMedivh->GetPositionZ());
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if(type != POINT_MOTION_TYPE)
                    return;

            uint32 CreatureID = me->GetEntry();
            if ((CreatureID == 17839 || CreatureID == 21104))
                return;

            if(id == 1)
            {
                Creature *pMedivh = (Creature*)(Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH)));
                if(pMedivh)
                {
                    DoCast(pMedivh, CORRUPT_MEDIVH);
                }
                IsChanneling = true;
            }
        }

        void EnterCombat(Unit *who)
        {
            me->InterruptNonMeleeSpells(false);
            IsChanneling = false;
        }

        void MoveInLineOfSight(Unit *who)
        {
            uint32 CreatureID = me->GetEntry();
            if (!(CreatureID == 17839 || CreatureID == 21104))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }
        void UpdateAI(const uint32 diff)
        {
            Creature *pMedivh = (Creature*)(Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH)));
            // If we channel corrupt on Medivh, lower Shield by 1% every 3 seconds
            if(IsChanneling)
            {
                if(Corrupt_Timer < diff)
                {
                    if(pInstance)
                    {
                        uint32 ShieldPercent = pInstance->GetData(DATA_SHIELDPERCENT);
                        pInstance->SetData(DATA_SHIELDPERCENT, ShieldPercent-1);
                        if(pMedivh)
                        {
                            ((npc_medivh_bm::mob_medivhAI *)pMedivh->AI())->UpdateWorldState(2540, ShieldPercent-1);
                            if(!pMedivh->isDead() && ShieldPercent <= 0)
                            {
                                me->DealDamage(pMedivh, pMedivh->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                            
                            }
                        }
                    }
                    Corrupt_Timer = 3000;
                }else Corrupt_Timer -= diff;
            }

            if(pInstance->GetData(DATA_MEDIVHDEATH) == 1)
            {
                me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                me->RemoveCorpse();
                return;
            }

            //Return since we have no target
            if (!UpdateVictim())
                return;

            uint32 CreatureID = me->GetEntry();

            if(me->getVictim()->GetTypeId() == TYPEID_PLAYER)
            {
                //AI's for trash mobs / mini-elite bosses
                switch (CreatureID)
                {
                //Rift Keeper
                case 21104:
                    if (me->GetHealth()*100 / me->GetMaxHealth() < 20)
                    {
                        DoCast(me, ENRAGE);
                        Keeper_Enrage_Timer = 120000;
                    }else Keeper_Enrage_Timer -= diff;

                    if(Keeper_Type == 0)
                    {
                        if(Keeper_BlastWave_Timer < diff)
                        {
                            DoCast(me->getVictim(), BLAST_WAVE);
                            Keeper_BlastWave_Timer = 9999999;
                        }else Keeper_BlastWave_Timer -= diff;

                        if(Keeper_FrostBolt_Timer < diff)
                        {
                            Unit *ptarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
                            DoCast(ptarget, FROST_BOLT_KEEPER);
                            Keeper_FrostBolt_Timer = 2000+rand()%2000;
                        }else Keeper_FrostBolt_Timer -= diff;

                        if(Keeper_Polymorph_Timer < diff)
                        {
                            Unit *ptarget = SelectTarget(SELECT_TARGET_TOPAGGRO, 1);
                            DoCast(ptarget, POLYMORPH);
                            Keeper_Polymorph_Timer = 9999999;
                        }else Keeper_Polymorph_Timer -= diff;

                        if(Keeper_Pyroblast_Timer < diff)
                        {
                            Unit *ptarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
                            DoCast(ptarget, PYROBLAST);
                            Keeper_Pyroblast_Timer = 15000;
                        }else Keeper_Pyroblast_Timer -= diff;
                    }
                    else
                    {
                        if(Keeper_ShadowBoltValley_Timer < diff)
                        {
                            DoCast(me->getVictim(), SHADOW_BOLT_VALLEY);
                            Keeper_ShadowBoltValley_Timer = 20000;
                        }else Keeper_ShadowBoltValley_Timer -= diff;

                        if(Keeper_Curse_Timer < diff)
                        {
                            Unit *ptarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
                            DoCast(ptarget, CURSE_OF_VULNERABILITY);
                            Keeper_Curse_Timer = 9999999;
                        }else Keeper_Curse_Timer -= diff;

                        if(Keeper_Fear_Timer < diff)
                        {
                            Unit *ptarget = SelectTarget(SELECT_TARGET_TOPAGGRO, 1);
                            DoCast(ptarget, FEAR);
                            Keeper_Fear_Timer = 9999999;
                        }else Keeper_Fear_Timer -= diff;
                    }
                    break;
                //Rift Lord
                case 17839:
                    if (me->GetHealth()*100 / me->GetMaxHealth() < 20)
                    {
                        DoCast(me, ENRAGE);
                        Lord_Enrage_Timer = 120000;
                    }else Lord_Enrage_Timer -= diff;

                    if(Lord_Hamstring_Timer < diff)
                    {
                        DoCast(me->getVictim(), HAMSTRING);
                        Lord_Hamstring_Timer = 9999999;
                    }else Lord_Hamstring_Timer -= diff;

                    if(Lord_Knockdown_Timer < diff)
                    {
                        DoCast(me->getVictim(), KNOCKDOWN);
                        Lord_Knockdown_Timer = 9999999;
                    }else Lord_Knockdown_Timer -= diff;

                    if(Lord_MortalStrike_Timer < diff)
                    {
                        DoCast(me->getVictim(), MORTAL_STRIKE);
                        Lord_MortalStrike_Timer = 9999999;
                    }else Lord_MortalStrike_Timer -= diff;

                    if(Lord_SunderArmor_Timer < diff)
                    {
                        DoCast(me->getVictim(), SUNDER_ARMOR);
                        Lord_SunderArmor_Timer = 45000;
                    }else Lord_SunderArmor_Timer -= diff;

                    if(Lord_Thunderclap_Timer < diff)
                    {
                        DoCast(me->getVictim(), THUNDERCLAP);
                        Lord_Thunderclap_Timer = 9999999;
                    }else Lord_Thunderclap_Timer -= diff;

                    break;
                //Infinite Assassin
                case 17835:
                    if(Assasin_Backstab_Timer < diff)
                    {
                        DoCast(me->getVictim(), BACKSTAB);
                        Assasin_Backstab_Timer = 9999999;
                    }else Assasin_Backstab_Timer -= diff;

                    if(Assasin_KidneyShot_Timer < diff)
                    {
                        DoCast(me->getVictim(), KIDNEY_SHOT);
                        Assasin_KidneyShot_Timer = 9999999;
                    }else Assasin_KidneyShot_Timer -= diff;

                    if(Assasin_Rupture_Timer < diff)
                    {
                        DoCast(me->getVictim(), RUPTURE);
                        Assasin_Rupture_Timer = 9999999;
                    }else Assasin_Rupture_Timer -= diff;

                    if(Assasin_SinisterStrike_Timer < diff)
                    {
                        DoCast(me->getVictim(), SINISTER_STRIKE);
                        Assasin_SinisterStrike_Timer = 10000;
                    }else Assasin_SinisterStrike_Timer -= diff;

                    break;
                //Infinite Chronomancer
                case 17892:
                    if(Chrono_ArcaneBolt_Timer < diff)
                    {
                        DoCast(me->getVictim(), ARCANE_BOLT);
                        Chrono_ArcaneBolt_Timer = 9999999;
                    }else Chrono_ArcaneBolt_Timer -= diff;

                    if(Chrono_ArcaneExplosion_Timer < diff)
                    {
                        DoCast(me->getVictim(), ARCANE_EXPLOSION);
                        Chrono_ArcaneExplosion_Timer = 9999999;
                    }else Chrono_ArcaneExplosion_Timer -= diff;

                    if(Chrono_FrostNova_Timer < diff)
                    {
                        DoCast(me->getVictim(), FROST_NOVA);
                        Chrono_FrostNova_Timer = 9999999;
                    }else Chrono_FrostNova_Timer -= diff;

                    if(Chrono_FrostBolt_Timer < diff)
                    {
                        DoCast(me->getVictim(), FROST_BOLT_CHRONO);
                        Chrono_FrostBolt_Timer = 9999999;
                    }else Chrono_FrostBolt_Timer -= diff;

                    break;
                //Infinite Executioner
                case 18994:
                    if(Executioner_Cleave_Timer < diff)
                    {
                        DoCast(me->getVictim(), CLEAVE);
                        Executioner_Cleave_Timer = 7000;
                    }else Executioner_Cleave_Timer -= diff;

                    if(Executioner_Hamstring_Timer < diff)
                    {
                        DoCast(me->getVictim(), HAMSTRING);
                        Executioner_Hamstring_Timer = 9999999;
                    }else Executioner_Hamstring_Timer -= diff;

                    if(Executioner_Overpower_Timer < diff)
                    {
                        DoCast(me->getVictim(), OVERPOWER);
                        Executioner_Overpower_Timer = 9999999;
                    }else Executioner_Overpower_Timer -= diff;

                    if(Executioner_Strike_Timer < diff)
                    {
                        DoCast(me->getVictim(), STRIKE);
                        Executioner_Strike_Timer = 15000;
                    }else Executioner_Strike_Timer -= diff;

                    break;
                //Infinite Vanquisher
                case 21139:
                    break;
                //Infinite Whelp
                case 21818:
                    break;
                }
            }

            if (!IsChanneling)
                DoMeleeAttackIfReady();
        }

        void KilledUnit(Unit *who)
        {
            Creature *pMedivh = (Creature*)(Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH)));
            uint32 CreatureID = me->GetEntry();
        
            if(!me->getVictim())
            {
                if (!(CreatureID == 17839 || CreatureID == 21104))
                {
                    IsChanneling = false;
                }
            }
        }
    };
};

#define SAY_SAAT_WELCOME "Stop! Do not go further, mortals. You are ill-prepared to face the forces of the Infinite Dragonflight. Come, let me help you."

class npc_saat : public CreatureScript
{
public:
    npc_saat() : CreatureScript("npc_saat") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_saatAI (pCreature);
    }

    bool GossipHello_npc_saat(Player *player, Creature *_Creature)
    {
        if( _Creature->isQuestGiver() )
        {
            player->PrepareQuestMenu( _Creature->GetGUID() );
            player->SendPreparedQuest(_Creature->GetGUID());
        }

        InstanceScript* pInstance = _Creature->GetInstanceScript();
        if(!pInstance->IsEncounterInProgress() && player->GetQuestStatus(10296) == QUEST_STATUS_COMPLETE)
        {
            player->ADD_GOSSIP_ITEM(0,"Give me a Chrono Beacon <Placeholder>",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature),_Creature->GetGUID());
        }
        return true; 
    }

    bool GossipSelect_npc_saat(Player *player, Creature *_Creature, uint32 sender, uint32 action )
    {
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,34975,false);
        }
        return true;
    }

    struct  npc_saatAI : public ScriptedAI
    {
        npc_saatAI(Creature *c) : ScriptedAI(c) 
        {
            once = false;
        }

        bool once;

        void Reset()
        {
             //me->SetAggressive(true);
        }
        void EnterCombat(Unit *who){}
        void MoveInLineOfSight(Unit *who)
        {
            if (!me->IsHostileTo(who) && !once && me->IsWithinDistInMap(who, 20))
            {
                me->MonsterSay(SAY_SAAT_WELCOME,LANG_UNIVERSAL, 0);
                once = true;
            }
        }

        void UpdateAI(const uint32 diff){}
    };
};

#define SPELL_SANDBREATH_TIMEKEEPER             31478

class mob_time_keeper : public CreatureScript
{
public:
    mob_time_keeper() : CreatureScript("mob_time_keeper") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_time_keeperAI (pCreature);
    }

    struct  mob_time_keeperAI : public ScriptedAI
    {
        mob_time_keeperAI(Creature *c) : ScriptedAI(c){}

        uint32 death_timer;
        uint32 breath_timer;

        void Reset()
        {
            death_timer = 60000;
            breath_timer = 10000;
        }
        void EnterCombat(Unit *who){}
        void UpdateAI(const uint32 diff)
        {
            if(death_timer < diff)
            {
                me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                me->RemoveCorpse();
                death_timer = 99999999;
            }else death_timer -= diff;

            if (!UpdateVictim())
                return;

            if(breath_timer < diff)
            {
                DoCast(me,SPELL_SANDBREATH_TIMEKEEPER);
                breath_timer = 10000;
            }else breath_timer -= diff;
        }
    };
};

void AddSC_dark_portal()
{
    new npc_medivh_bm();
    new npc_time_rift();
    new mobs_infinite_adds();
    new mob_time_keeper();
    new npc_saat();
}
