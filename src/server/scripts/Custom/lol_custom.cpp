/* Copyright (C) 2009 - 2010 BroodWyrm > */

#include "ScriptPCH.h"
#include "SpellMgr.h"
#include "Spell.h"
#include "Player.h"
#include "Channel.h"
#include "Config.h"

/*######
## mob_converted_sentry
##Quest 11524,11525
######*/

class mob_arcane_sentries : public CreatureScript
{
public:
    mob_arcane_sentries() : CreatureScript("mob_arcane_sentries") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_arcane_sentriesAI (_Creature);
    }

    struct mob_arcane_sentriesAI : public ScriptedAI
    {
        mob_arcane_sentriesAI(Creature *c) : ScriptedAI(c) { }

        void Reset(){    }
        void EnterCombat(Unit *who) { }

        void SpellHit(Unit* caster, const SpellEntry* spell)
        {
            if(caster->GetTypeId() == TYPEID_PLAYER)
            {
                switch(spell->Id)
                {
                case 44997:
                    if(me->isDead())
                    {
                        me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                        me->RemoveCorpse();
                    }
                }
            }

        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

class item_wyrm_attuned_crystal_cores : public ItemScript
{
public:
    item_wyrm_attuned_crystal_cores() : ItemScript("item_wyrm_attuned_crystal_cores") { }
    /*#####
    # item_attuned_crystal_cores
    #####*/

    bool ItemUse_item_wyrm_attuned_crystal_cores(Player *player, Item* _Item, SpellCastTargets const& targets)
    {
        if( targets.getUnitTarget() && targets.getUnitTarget()->GetTypeId()==TYPEID_UNIT && targets.getUnitTarget()->GetEntry() == 24972 && targets.getUnitTarget()->isDead() && (player->GetQuestStatus(11524) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(11525) == QUEST_STATUS_INCOMPLETE) )
            return false;

        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW,_Item,NULL);
        return true;
    }
};

/*######
## mob_wyrm_dragonmaw_peon
##Quest 11055, 11020
######*/

#define SPELL_DAZE              40714
#define SPELL_ENRAGE            40735
#define SPELL_SLEEP             40732

class mob_wyrm_dragonmaw_peon : public CreatureScript
{
public:
    mob_wyrm_dragonmaw_peon() : CreatureScript("mob_wyrm_dragonmaw_peon") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_wyrm_dragonmaw_peonAI (_Creature);
    }

struct mob_wyrm_dragonmaw_peonAI : public ScriptedAI
{
    mob_wyrm_dragonmaw_peonAI(Creature *c) : ScriptedAI(c) { }

    bool sleep;
    uint32 statechange_timer;
    uint32 EatTimer;
    bool eventrunning;
    bool eating;
    uint64 PlayerGUID;

    void Reset()
    {
        switch (rand()%4)
        {
        case 0:
            sleep = true;
            me->UpdateEntry(23311);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_ONESHOT_NONE);
            switch(rand()%2)
            {
            case 0: me->CastSpell(me,SPELL_DAZE,true); break;
            case 1: me->CastSpell(me,SPELL_SLEEP,true); break;
            case 2: me->CastSpell(me,SPELL_ENRAGE,true); break;
            }
            //me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_STATE_SLEEP);
            //me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_ONESHOT_NONE);
            //me->setEmoteState(EMOTE_STATE_SLEEP);
            //me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_STATE_SIT);

            statechange_timer = 20000+rand()%60000;
            break;
        case 1:
            sleep = false;
            me->RemoveAurasDueToSpell(SPELL_DAZE);
            me->RemoveAurasDueToSpell(SPELL_ENRAGE);
            me->RemoveAurasDueToSpell(SPELL_SLEEP);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_STATE_WORK_MINING);
            statechange_timer = 20000+rand()%60000;
            break;
        }
        eventrunning = false;
        eating = false;
        PlayerGUID = false;


    }
    void EnterCombat(Unit *who)
    {
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if(type != POINT_MOTION_TYPE)
            return;

        if(id == 1)
        {
            eating = true;
            EatTimer = 5000;
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_EAT_NOSHEATHE);
        }
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(caster && caster->GetTypeId() == TYPEID_PLAYER)
        {
            switch(spell->Id)
            {
            case 40742:
                if((((Player*)caster)->GetQuestStatus(11055) == QUEST_STATUS_INCOMPLETE))
                {
                    if(sleep && !eventrunning)
                    {
                        switch(rand()%5)
                        {
                        case 0: me->MonsterSay("ARGH! BOOTERANG!",LANG_UNIVERSAL,NULL); break;
                        case 1: me->MonsterSay("OWWWW! Ok, ok, me go back to work!",LANG_UNIVERSAL,NULL); break;
                        case 2: me->MonsterSay("AYAYA! one day me have dat booterang...",LANG_UNIVERSAL,NULL); break;
                        case 3: me->MonsterSay("HEY! No more booterang! Me sorry! Me work!",LANG_UNIVERSAL,NULL); break;
                        case 4: me->MonsterSay("WHY IT PUT DA BOOTERANG ON DA SKIN?? WHY??",LANG_UNIVERSAL,NULL); break;
                        }

                        me->UpdateEntry(22252);
                        me->RemoveAurasDueToSpell(SPELL_DAZE);
                        me->RemoveAurasDueToSpell(SPELL_ENRAGE);
                        me->RemoveAurasDueToSpell(SPELL_SLEEP);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK_MINING);
                        ((Player*)caster)->CastedCreatureOrGO(23311, me->GetGUID(),40742);
                        sleep = false;
                        statechange_timer = 20000+rand()%60000;
                    }
                }
                break;
            case 40468:
                eventrunning = true;
                PlayerGUID = caster->GetGUID();
                float PlayerX, PlayerY, PlayerZ;
                caster->GetClosePoint(PlayerX, PlayerY, PlayerZ, 1);
                (*me).GetMotionMaster()->MovePoint(1, PlayerX, PlayerY, PlayerZ);
                break;
            }
        }

    }

    void UpdateAI(const uint32 diff)
    {        
        if(eventrunning)
        {
            if (me->isDead())
            return;

            if(eating)
            {
                if(EatTimer < diff)
                {
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_ONESHOT_NONE);
                    Player* plr = ((Player*)Unit::GetUnit((*me), PlayerGUID));
                    plr->KilledMonsterCredit(23209, me->GetGUID());
                    me->DealDamage( me,  me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                    me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                    eating = false;
                } else EatTimer -= diff;
            }

            return;
        }else
        {     

            if (!UpdateVictim())
            {
                if(statechange_timer <= diff)
                {
                    if(sleep)
                    {
                        me->RemoveAurasDueToSpell(SPELL_DAZE);
                        me->RemoveAurasDueToSpell(SPELL_ENRAGE);
                        me->RemoveAurasDueToSpell(SPELL_SLEEP);
                        me->UpdateEntry(22252);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK_MINING);
                        sleep = false;
                    }else
                    {
                        //me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_STATE_SLEEP);
                        //me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_STATE_SIT);
                        me->UpdateEntry(23311);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_ONESHOT_NONE);
                        
                        switch(rand()%3)
                        {
                        case 0: me->CastSpell(me,SPELL_DAZE,true); break;
                        case 1: me->CastSpell(me,SPELL_ENRAGE,true); break;
                        case 2: me->CastSpell(me,SPELL_SLEEP,true); break;
                        }

                        //me->setEmoteState(EMOTE_STATE_SLEEP);
                        sleep = true;
                    }
                    statechange_timer = 20000+rand()%60000;
                }else statechange_timer -= diff;

                return;
            }

            DoMeleeAttackIfReady();
        }
    }
};
};

/*######
## mob_felblood_initiate
##Quest 11515
######*/

#define ENTRY_FELBLOOD_INITIATE     24918
#define ENTRY_EMACIATED_FELBLOOD    24955

class mob_felblood_initiate : public CreatureScript
{
public:
    mob_felblood_initiate() : CreatureScript("mob_felblood_initiate") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_felblood_initiateAI (_Creature);
    }

    struct mob_felblood_initiateAI : public ScriptedAI
    {
        mob_felblood_initiateAI(Creature *c) : ScriptedAI(c) { }

        void Reset(){}
        void EnterCombat(Unit *who) { }

        void SpellHit(Unit* caster, const SpellEntry* spell)
        {
            switch(spell->Id)
            {
            case 44936:
                    me->UpdateEntry(ENTRY_EMACIATED_FELBLOOD);
                    me->GetMotionMaster()->Clear(true);
                    me->GetMotionMaster()->MoveChase(me->getVictim());
                break;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## mob_burning_legion_demon
## Quest 11538,11537
######*/

#define BURNING_LEGION_DEMON            25068

class mob_emissary_of_hate : public CreatureScript
{
public:
    mob_emissary_of_hate() : CreatureScript("mob_emissary_of_hate") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_emissary_of_hateAI (_Creature);
    }

    struct mob_emissary_of_hateAI : public ScriptedAI
    {
        mob_emissary_of_hateAI(Creature *c) : ScriptedAI(c) { }

        void Reset(){}
        void EnterCombat(Unit *who) { }

        void SpellHit(Unit* caster, const SpellEntry* spell)
        {
            if(caster && caster->GetTypeId() == TYPEID_PLAYER)
            {
                switch(spell->Id)
                {
                case 45030:
                    ((Player*)caster)->KilledMonsterCredit(25065 , me->GetGUID());
                    break;
                }
            }

        }
    };
};

/*######
## mob_shattrath_banish
######*/

#define SPELL_BANISH_1              36642
#define SPELL_BANISH_2              36671
#define SPELL_DEBUFF_EXILE          39533
#define SPELL_DEBUFF_SICKNESS       15007
#define SPELL_TELEPORT              36643

class mob_shattrath_banish : public CreatureScript
{
public:
    mob_shattrath_banish() : CreatureScript("mob_shattrath_banish") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_shattrath_banishAI (_Creature);
    }

    struct mob_shattrath_banishAI : public ScriptedAI
    {
        mob_shattrath_banishAI(Creature *c) : ScriptedAI(c) { }

        uint32 banish_timer;
        uint32 banishteleport_timer;

        void Reset()
        {
            banish_timer = 2000;
            banishteleport_timer = 9000;
        }
        void EnterCombat(Unit *who) { }
        void MoveInLineOfSight(Unit* ){}

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if(banish_timer <= diff)
            {
                if(me->getVictim()->GetTypeId() == TYPEID_PLAYER)
                {
                    switch(rand()%2)
                    {
                    case 0:
                        DoCast(me->getVictim(), SPELL_BANISH_1);
                        break;
                    case 1:
                        DoCast(me->getVictim(), SPELL_BANISH_2);
                        break;
                    }
                    banishteleport_timer = 8000;
                    banish_timer = 12000;
                }
            }else banish_timer -= diff;

            if(banishteleport_timer <= diff)
            {
                if(me->getVictim()->GetTypeId() == TYPEID_PLAYER)
                {
                    Unit* victim = me->getVictim();
                    if(!victim->HasAura(SPELL_BANISH_1,1) && !victim->HasAura(SPELL_BANISH_2,1))
                    {
                        victim->CastSpell(victim,SPELL_DEBUFF_EXILE,true);
                        victim->CastSpell(victim,SPELL_DEBUFF_SICKNESS,true);
                        victim->CastSpell(victim,SPELL_TELEPORT,true);
                    
                        banishteleport_timer = 12000;
                        EnterEvadeMode();
                    }
                }
            }else banishteleport_timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_dragonmaw_illusion
######*/

#define SPELL_DRAGONMAW_ILLUSION            40214

class npc_dragonmaw_illusion : public CreatureScript
{
public:
    npc_dragonmaw_illusion() : CreatureScript("npc_dragonmaw_illusion") { }

    bool OnGossipHello(Player *player, Creature *_Creature)
    {
        if(player->GetQuestStatus(11013) != QUEST_STATUS_NONE && !player->HasAura(SPELL_DRAGONMAW_ILLUSION,0))
        {
            player->ADD_GOSSIP_ITEM(0,"Segne mich mich mit eurer Magie.",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature),_Creature->GetGUID());
        }
        return true; 
    }

    bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action )
    {
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            if(player->IsMounted())
            {
                player->Unmount();
                player->RemoveAurasByType(SPELL_AURA_MOUNTED);
            }
            player->CastSpell(player,SPELL_DRAGONMAW_ILLUSION,false);
        }
        return true;
    }
};


/*######
## mob_living_flare
##Quest 11516
######*/

#define SPELL_LIVING_FLARE_COSMETIC         44880
#define SPELL_LIVING_FLARE_MASTER           44877
#define SPELL_UNSTABLE_FLAME_COSMETIC       46196
#define SPELL_FLAME_QUEST_CREDIT            44947
#define SPELL_LIVING_FLARE_DETONATION       44948

#define SPELL_FLARE_FLAME_UP                44944

float PortalPoint[3] = {835,2521,292.5};

class mob_living_flare : public CreatureScript
{
public:
    mob_living_flare() : CreatureScript("mob_living_flare") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_living_flareAI (_Creature);
    }

    struct mob_living_flareAI : public ScriptedAI
    {
        mob_living_flareAI(Creature *c) : ScriptedAI(c)
        {
            isUnstable = false;
            explosion = false;
            grow_state = 0;
        }

        uint32 grow_state;
        bool isUnstable;
        bool explosion;

        void Reset()
        {
            me->CastSpell(me,isUnstable ? SPELL_UNSTABLE_FLAME_COSMETIC : SPELL_LIVING_FLARE_COSMETIC,true);
        }
        void EnterCombat(Unit *who) { }

        void MovementInform(uint32 type, uint32 id)
        {
             if(type != POINT_MOTION_TYPE)
                    return;
             if(id == 1)
             {
                 Unit* owner = me->GetOwner();
                 if(owner && owner->GetTypeId() == TYPEID_PLAYER)
                 {
                     Player* pOwner = (Player*)owner;
                     if(pOwner->GetQuestStatus(11516) == QUEST_STATUS_INCOMPLETE)
                         pOwner->CompleteQuest(11516);
                 }
                 //me->CastSpell(owner,SPELL_FLAME_QUEST_CREDIT,true);
                 me->CastSpell(me,SPELL_LIVING_FLARE_DETONATION,false);
                 me->DespawnOrUnsummon();
             }
        }

        void SpellHit(Unit* caster, const SpellEntry* spell)
        {
            //error_log("Hitted by spell %d", spell->Id);

            if(isUnstable)
                return;

            if(spell->Id == SPELL_LIVING_FLARE_MASTER)
            {
                grow_state++;
                me->CastSpell(me,SPELL_FLARE_FLAME_UP,true);
            }

            if(grow_state >= 8)
            {
                me->UpdateEntry(24958);
                me->SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
                isUnstable = true;
                me->SetHealth(me->GetMaxHealth());
                me->CastSpell(me,SPELL_UNSTABLE_FLAME_COSMETIC,true);
            }
         }

        void UpdateAI(const uint32 diff)
        {
            if(!explosion)
            {

                if(!me->HasUnitState(UNIT_STAT_FOLLOW))
                {
                    if(me->GetOwner())
                    {
                        me->GetMotionMaster()->MoveFollow(me->GetOwner(),PET_FOLLOW_DIST,PET_FOLLOW_ANGLE);
                    }
                }

                if(!isUnstable)
                    return;

                float distance = me->GetDistance2d(PortalPoint[0],PortalPoint[1]);
                if(distance < 25)
                {
                    me->GetMotionMaster()->MovePoint(1,PortalPoint[0],PortalPoint[1],PortalPoint[2]);
                    explosion = true;
                }
            }
        }
    };
};

class mob_incandescent_fel_spark : public CreatureScript
{
public:
    mob_incandescent_fel_spark() : CreatureScript("mob_incandescent_fel_spark") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new incandescent_fel_sparkAI (_Creature);
    }

    struct incandescent_fel_sparkAI : public ScriptedAI
    {
        incandescent_fel_sparkAI(Creature *c) : ScriptedAI(c)
        {
            explosion = false;
        }
        bool explosion;
        uint32 wait_timer;
        uint64 killer;

        void Reset()
        {
            killer = 0;
            wait_timer = 0;
        }
        void EnterCombat(Unit *who) { }
        void JustDied(Unit *killer)
        {
            //float x,y,z;
            //me->GetPosition(x,y,z);
            //Creature* trigger = me->SummonTrigger(me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),0,4000);
            //if(trigger) 
            if(killer && killer->GetTypeId() == TYPEID_PLAYER)
            {
                 Player* pKiller = (Player*)killer;
                 if(pKiller->GetQuestStatus(11516) == QUEST_STATUS_INCOMPLETE)
                     pKiller->CastSpell(killer,SPELL_LIVING_FLARE_MASTER,true,0,0,me->GetGUID());
            }
            //Creature* trigger = me->SummonCreature(21252,x,y,z,0,TEMPSUMMON_TIMED_DESPAWN,4000);
            //if(trigger) trigger->CastSpell(trigger,SPELL_LIVING_FLARE_MASTER,true,0,0,me->GetGUID());
        }
        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim() )
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## mob_flymaster
######*/

enum FlymasterTyp
{
    Bathander,
    Dragonhawkhander,
    Wyvernhander,
    Gryphonhander,
    Hypogryphhander,
    Neutralhander
};

#define ENTRY_BAT                   9521
#define ENTRY_GRYPHON               9526
#define ENTRY_HYPOGRYPHON           9527
#define ENTRY_WYVERN                9297
#define ENTRY_DRAGONHAWK            27946

class mob_flymaster : public CreatureScript
{
public:
    mob_flymaster() : CreatureScript("mob_flymaster") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_flymasterAI (_Creature);
    }

    struct mob_flymasterAI : public ScriptedAI
    {
        mob_flymasterAI(Creature *c) : ScriptedAI(c) { }

        FlymasterTyp HanderTyp;
        uint32 SpawnTimer;

        void Reset()
        {
            HanderTyp = GetType();
            SpawnTimer = 30000;
        }
        void MoveInLineOfSight(Unit* ){}
        void EnterCombat(Unit *who)
        {
            SpawnGuardian(HanderTyp,who);
        }

        FlymasterTyp GetType()
        {
            switch(me->GetEntry())
            {
            case 2389:
            case 16189:
            case 12636:
            case 16192:
            case 4551:
            case 2226:
                return Bathander;
            case 26560:
                return Dragonhawkhander;
            case 22931:
            case 10583:
            case 24851:
            case 23612:
            case 16227:
            case 22216:
            case 18938:
            case 18940:
            case 19581:
            case 22455:
            case 21766:
            case 20515:
            case 19583:
                return Neutralhander;
            case 20234:
            case 18809:
            case 8018:
            case 8609:
            case 18939:
            case 7823:
            case 12596:
            case 12617:
            case 21107:
            case 18931:
            case 16822:
            case 24366:
            case 1571:
            case 1572:
            case 2835:
            case 2409:
            case 523:
            case 2941:
            case 1573:
            case 2299:
            case 352:
            case 4321:
            case 931:
            case 2859:
            case 2432:
                return Gryphonhander;
            case 3838:
            case 3841:
            case 15177:
            case 18937:
            case 17555:
            case 18785:
            case 18788:
            case 18789:
            case 17554:
            case 4267:
            case 4319:
            case 1233:
            case 6706:
            case 22935:
            case 22485:
            case 10897:
            case 11138:
            case 4407:
            case 12577:
            case 12578:
            case 8019:
                return Hypogryphhander;
            case 2861:
            case 19558:
            case 2858:
            case 18942:
            case 1387:
            case 19317:
            case 2851:
            case 20762:
            case 8020:
            case 18953:
            case 18930:
            case 2995:
            case 11901:
            case 4312:
            case 11899:
            case 11139:
            case 4314:
            case 10378:
            case 8610:
            case 4317:
            case 7824:
            case 6726:
            case 12616:
            case 12740:
            case 13177:
            case 18808:
            case 18807:
            case 18791:
            case 14242:
            case 3305:
            case 16587:
            case 3310:
            case 3615:
            case 11900:
            case 15178:
            case 6026:
                return Wyvernhander;
            default:
                return Neutralhander;
            }
        }

        void SpawnGuardian(FlymasterTyp type, Unit *target)
        {
            uint32 SpawnEntry = 0;
            switch(type)
            {
            case Bathander:
                SpawnEntry = ENTRY_BAT;
                break;
            case Dragonhawkhander:
                SpawnEntry = ENTRY_DRAGONHAWK;
                break;
            case Wyvernhander:
                SpawnEntry = ENTRY_WYVERN;
                break;
            case Gryphonhander:
                SpawnEntry = ENTRY_GRYPHON;
                break;
            case Hypogryphhander:
                SpawnEntry = ENTRY_HYPOGRYPHON;
                break;
            case Neutralhander:
                bool isHorde = (target->getFaction() == 1610 ||target->getFaction() == 2 ||target->getFaction() == 6 ||target->getFaction() == 116 ||target->getFaction() == 5) ;
                if(isHorde)
                    SpawnEntry = ENTRY_GRYPHON;
                else
                    SpawnEntry = ENTRY_WYVERN;
                break;
            }

            for(int i = 0; i < 2; i++)
            {
                Creature* spawn = DoSpawnCreature(SpawnEntry,0,0,0,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,60000);
                spawn->AI()->AttackStart(target);
            }
        }
        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (SpawnTimer <= diff)
            {
                SpawnGuardian(HanderTyp,me->getVictim());
                SpawnTimer = 30000;
            }else SpawnTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## Key NPCs
######*/

#define SPELL_CREATE_SHATTERED_HALLS_KEY    54884
#define ENTRY_SHATTERED_HALLS_KEY           28395
#define HELLFIRE_SMITH_KEY                  "[PH] Ich habe den Schluessel zu den Zerschmetterten Hallen verloren.Kannst du mir helfen?"

class npc_hellfire_smith : public CreatureScript
{
public:
    npc_hellfire_smith() : CreatureScript("npc_hellfire_smith") { }

    bool OnGossipHello(Player *player, Creature *_Creature)
    {
        if (_Creature->isQuestGiver())
            player->PrepareQuestMenu(_Creature->GetGUID());

        if( _Creature->isVendor() )
            player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        if( _Creature->isTrainer() )
            player->ADD_GOSSIP_ITEM(3, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);

        if( ( ( player->GetQuestStatus(10758) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(10758)) || ( player->GetQuestStatus(10764) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(10764)) ) && !player->HasItemCount(ENTRY_SHATTERED_HALLS_KEY,1))
            player->ADD_GOSSIP_ITEM(0,HELLFIRE_SMITH_KEY,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature),_Creature->GetGUID());

        return true; 
}

    bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action )
    {

        switch(action)
        {
        case GOSSIP_ACTION_INFO_DEF+1:
            {
                player->CLOSE_GOSSIP_MENU();
                ItemPosCountVec dest;
                uint8 canStoreNewItem = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ENTRY_SHATTERED_HALLS_KEY, 1);
                if(canStoreNewItem == EQUIP_ERR_OK)
                {
                    Item *newItem = NULL;
                    newItem = player->StoreNewItem(dest,ENTRY_SHATTERED_HALLS_KEY,1,true);
                    player->SendNewItem(newItem,1,true,false);
                }
            }
            break;
        case GOSSIP_ACTION_TRAIN:
            player->SEND_TRAINERLIST( _Creature->GetGUID() );
            break;
        case GOSSIP_ACTION_TRADE:
            player->SEND_VENDORLIST( _Creature->GetGUID() );
            break;
        }
        return true;
    }
};

#define ENTRY_ARCATRAZ_KEY                      31084
#define SPECIAL_ADAL                            "[PH] Ich habe den Schluessel zur Arkatraz verloren. Kannst du mir helfen?"
#define SPECIAL_ADAL_2                          "[PH] Ich habe das Medallion von Karabor verloren. Kannst du mir helfen?"


#define ENTRY_MEDALLION_OF_KARABOR              32649
#define ENTRY_BLESSED_MEDALLION_OF_KARABOR      32757

class npc_adal : public CreatureScript
{
public:
    npc_adal() : CreatureScript("npc_adal") { }

    bool OnGossipHello(Player *player, Creature *_Creature)
    {
        if (_Creature->isQuestGiver())
            player->PrepareQuestMenu(_Creature->GetGUID());

        if( ( player->GetQuestStatus(10704) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(10704) ) && !player->HasItemCount(ENTRY_ARCATRAZ_KEY,1))
            player->ADD_GOSSIP_ITEM(0,SPECIAL_ADAL,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1);

        if((player->GetQuestStatus(10985) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(10985) ) || ( player->GetQuestStatus(13429) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(13429)))
        {
            if(player->GetQuestStatus(10959) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(10959))
            {
                if(!player->HasItemCount(ENTRY_BLESSED_MEDALLION_OF_KARABOR,1))
                    player->ADD_GOSSIP_ITEM(0,SPECIAL_ADAL_2,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+3);
            }
            else 
            {
                if(!player->HasItemCount(ENTRY_MEDALLION_OF_KARABOR,1))
                    player->ADD_GOSSIP_ITEM(0,SPECIAL_ADAL_2,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+2);
            }
        
        }

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature),_Creature->GetGUID());
        return true; 
    }

    bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action )
    {
        bool canSendItem = false;
        uint32 KeyEntry;
        switch (action)
        {
        case GOSSIP_ACTION_INFO_DEF+1:
            canSendItem = true;
            KeyEntry = ENTRY_ARCATRAZ_KEY;
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            canSendItem = true;
            KeyEntry = ENTRY_MEDALLION_OF_KARABOR;
            break;
         case GOSSIP_ACTION_INFO_DEF+3:
            canSendItem = true;
            KeyEntry = ENTRY_BLESSED_MEDALLION_OF_KARABOR;
            break;
        }

        player->CLOSE_GOSSIP_MENU();
        if(canSendItem)
        {
            ItemPosCountVec dest;
            uint8 canStoreNewItem = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, KeyEntry, 1);
            if(canStoreNewItem == EQUIP_ERR_OK)
            {
                Item *newItem = NULL;
                newItem = player->StoreNewItem(dest,KeyEntry,1,true);
                player->SendNewItem(newItem,1,true,false);
            }
        }

        return true;
    }
};

/*######
## mob_bomb_target
######*/

#define SPELL_SKETTIS_BOMB          39844
#define SPELL_OGRILAR_BOMB          40160

class mob_bomb_target : public CreatureScript
{
public:
    mob_bomb_target() : CreatureScript("mob_bomb_target") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_bomb_targetAI (_Creature);
    }

    struct mob_bomb_targetAI : public ScriptedAI
    {
        mob_bomb_targetAI(Creature *c) : ScriptedAI(c) { }

        void Reset()
        {
            switch(me->GetEntry())
            {
            case 23118:
                DoCast(me,40196,true);
                break;
            }
        }
        void EnterCombat(Unit *who) { }

        void SpellHit(Unit* caster, const SpellEntry* spell)
        {
            if(caster && caster->GetTypeId() == TYPEID_PLAYER)
            {
                GameObject* go;
                switch(spell->Id)
                {
                case SPELL_SKETTIS_BOMB:
                    go = GetClosestGameObjectWithEntry(me,185549,5);
                    if(go)
                    {
                        go->SetLootState(GO_NOT_READY);
                        go->SetRespawnTime(120);
                        go->SendObjectDeSpawnAnim(caster->GetGUID());
                    }

                    me->DealDamage(me,me->GetHealth());
                    me->RemoveCorpse();
                    me->SetRespawnTime(120);
                    break;
                case SPELL_OGRILAR_BOMB:
                    go = GetClosestGameObjectWithEntry(me,185861,5);
                    if(go)
                    {
                        go->SetLootState(GO_NOT_READY);
                        go->SetRespawnTime(120);
                        go->SendObjectDeSpawnAnim(caster->GetGUID());
                    }
                    me->CastSpell(me,40162,true);
                    me->DealDamage(me,me->GetHealth());
                    me->RemoveCorpse();
                    me->SetRespawnTime(120);
                    break;
                }
            }

        }
    };
};

/*######
## mob_bombingrun_target
######*/

class mob_bombingrun_target : public CreatureScript
{
public:
    mob_bombingrun_target() : CreatureScript("mob_bombingrun_target") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_bombingrun_targetAI (_Creature);
    }

    struct mob_bombingrun_targetAI : public ScriptedAI
    {
        mob_bombingrun_targetAI(Creature *c) : ScriptedAI(c) { }

        void Reset(){}
        void EnterCombat(Unit *who) { }
        void JustDied(Unit *killer)
        {
            me->RemoveCorpse();
            me->SetRespawnTime(30);
        }
    };
};

/*######
## mob_masskill_target
######*/

class mob_masskill_target : public CreatureScript
{
public:
    mob_masskill_target() : CreatureScript("mob_masskill_target") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_masskill_targetAI (_Creature);
    }

    struct mob_masskill_targetAI : public ScriptedAI
    {
        mob_masskill_targetAI(Creature *c) : ScriptedAI(c) { }

        void Reset(){}
        void EnterCombat(Unit *who) { }
        void JustDied(Unit *killer)
        {
            me->RemoveCorpse();
            me->SetRespawnTime(60);
        }
    };
};

/*######
## mob_doomguard_commander
######*/

class mob_doomguard_commander : public CreatureScript
{
public:
    mob_doomguard_commander() : CreatureScript("mob_doomguard_commander") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_doomguard_commanderAI (_Creature);
    }

    struct mob_doomguard_commanderAI : public ScriptedAI
    {
        mob_doomguard_commanderAI(Creature *c) : ScriptedAI(c) { }

        void Reset(){}
        void EnterCombat(Unit *who) { }
        void SpellHitTarget(Unit* target, const SpellEntry* spell)
        {
            //if( target->GetGUID() == me->GetGUID() )
            {
                switch(spell->Id)
                {
                case 23019:
                    float x,y,z;
                    me->GetPosition(x,y,z);
                    me->SummonGameObject(179644,x,y,z,0,0,0,0,0,300000);
                    me->DealDamage(me,me->GetHealth());
                    me->RemoveCorpse();
                    break;
                }
            }
        }
    };
};

/*######
## mob_null_creature
######*/

class mob_null_creature : public CreatureScript
{
public:
    mob_null_creature() : CreatureScript("mob_null_creature") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_null_creatureAI (_Creature);
    }

    struct mob_null_creatureAI : public NullCreatureAI
    {
        mob_null_creatureAI(Creature *c) : NullCreatureAI(c) { }
        bool IsVisible(Unit *) const { return true; }
    };
};

/*######
## npc_greengill_slave
######*/

#define ENRAGE  45111
#define ORB     45109
#define QUESTG  11541
#define DM      25060

class npc_wyrm_greengill_slave : public CreatureScript
{
public:
    npc_wyrm_greengill_slave() : CreatureScript("npc_wyrm_greengill_slave") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new npc_wyrm_greengill_slaveAI (_Creature);
    }

    struct npc_wyrm_greengill_slaveAI : public ScriptedAI
    {
        npc_wyrm_greengill_slaveAI(Creature* c) : ScriptedAI(c) {}

        uint64 PlayerGUID;

        void EnterCombat(Unit* who){}

        void Reset()
        {
            PlayerGUID = 0;
        }

        void SpellHit(Unit* caster, const SpellEntry* spell)
        {
            if(!caster)
                return;

            if(caster->GetTypeId() == TYPEID_PLAYER && spell->Id == ORB && !me->HasAura(ENRAGE, 0))
            {
                PlayerGUID = caster->GetGUID();
                if(PlayerGUID)
                {
                    Player* plr = Unit::GetPlayer(*me,PlayerGUID);
                    if(plr && plr->GetQuestStatus(QUESTG) == QUEST_STATUS_INCOMPLETE)
                        plr->KilledMonsterCredit(25086, me->GetGUID());
                }
                DoCast(me, ENRAGE);
                Creature* Myrmidon = GetClosestCreatureWithEntry(me, DM, 70);
                if(Myrmidon)
                {
                    me->AddThreat(Myrmidon, 100000.0f);
                    AttackStart(Myrmidon);
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            DoMeleeAttackIfReady();
        }
    };
};

/*##############
## Ring Scripts
##############*/

/*######
## npc_archmage_leryda  KaraRing
######*/

enum KaraRingQuests
{
    Q_ARCHMAGE = 10725,
    Q_PROTECTOR = 10728,
    Q_RESTORER = 10726,
    Q_ASSASSIN = 10727,

    Q_W_ARCHMAGE = 11031,
    Q_W_PROTECTOR = 11032,
    Q_W_RESTORER = 11034,
    Q_W_ASSASSIN = 11033,
};

enum KaraRings
{
    I_ARCHMAGE = 29287,
    I_PROTECTOR = 29279,
    I_RESTORER = 29290,
    I_ASSASSIN = 29283,
};

#define GOSSIP_TEXT             "Ich hab mein Ring verloren. Kannst du ihn wieder herzaubern?"

bool AddItemToPlayer(Player* player, uint32 ItemEntry)
{

        ItemPosCountVec dest;
        uint8 canStoreNewItem = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ItemEntry, 1);
        if(canStoreNewItem != EQUIP_ERR_OK)
            return false;

        Item *newItem = NULL;
        newItem = player->StoreNewItem(dest,ItemEntry,1,true);
        player->SendNewItem(newItem,1,true,false);

        return true;
};

class npc_archmage_leryda : public CreatureScript
{
public:
    npc_archmage_leryda() : CreatureScript("npc_archmage_leryda") { }

    bool OnGoosipHello(Player* player, Creature* _Creature)
    {
        if (_Creature->isQuestGiver())
            player->PrepareQuestMenu( _Creature->GetGUID() );

        if( !(player->HasItemCount(I_PROTECTOR,1,true) || player->HasItemCount(I_RESTORER,1,true) ||
            player->HasItemCount(I_ARCHMAGE,1,true) || player->HasItemCount(I_ASSASSIN,1,true)))
        {
            if(player->GetQuestStatus(Q_ARCHMAGE) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_ARCHMAGE))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            }else if(player->GetQuestStatus(Q_RESTORER) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_RESTORER))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            }else if(player->GetQuestStatus(Q_PROTECTOR) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_PROTECTOR))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            }else if(player->GetQuestStatus(Q_ASSASSIN) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_ASSASSIN))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            }
        }
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature), _Creature->GetGUID());
        return true;
    };

    bool OnGossipSelect(Player* player, Creature* _Creature, uint32 sender, uint32 action)
    {
        player->CLOSE_GOSSIP_MENU();
        switch(action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                if(AddItemToPlayer(player,I_ARCHMAGE))
                {
                    player->SetQuestStatus(Q_W_ARCHMAGE,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_W_ARCHMAGE].m_rewarded = false;
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                if(AddItemToPlayer(player,I_RESTORER))
                {
                    player->SetQuestStatus(Q_W_RESTORER,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_W_RESTORER].m_rewarded = false;
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                if(AddItemToPlayer(player,I_PROTECTOR))
                {
                    player->SetQuestStatus(Q_W_PROTECTOR,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_W_PROTECTOR].m_rewarded = false;
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                if(AddItemToPlayer(player,I_ASSASSIN))
                {
                    player->SetQuestStatus(Q_W_ASSASSIN,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_W_ASSASSIN].m_rewarded = false;
                }
            break;
        }

        return true;
    };
};

/*######
## npc_soridormi  HyjalRing
######*/

enum HyjalRingQuests
{
    Q_SAGE = 10472,
    Q_DEFENDER = 10475,
    Q_ETERNAL = 10473,
    Q_CHAMPION = 10474,

    Q_W_SAGE = 11103,
    Q_W_DEFENDER = 11106,
    Q_W_ETERNAL = 11104,
    Q_W_CHAMPION = 11105,
};

enum HyjalRings
{
    I_SAGE = 29305,
    I_DEFENDER = 29297,
    I_ETERNAL = 29309,
    I_CHAMPION = 29301,
};

class npc_soridormi : public CreatureScript
{
public:
	npc_soridormi() : CreatureScript("npc_soridormi") { }

    bool OnGoosipHello(Player* player, Creature* _Creature)
    {
        if (_Creature->isQuestGiver())
            player->PrepareQuestMenu( _Creature->GetGUID() );

        if( !(player->HasItemCount(I_SAGE,1,true) || player->HasItemCount(I_DEFENDER,1,true) ||
            player->HasItemCount(I_ETERNAL,1,true) || player->HasItemCount(I_CHAMPION,1,true)))
        {
            if(player->GetQuestStatus(Q_SAGE) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_SAGE))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            }else if(player->GetQuestStatus(Q_ETERNAL) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_ETERNAL))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            }else if(player->GetQuestStatus(Q_DEFENDER) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_DEFENDER))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            }else if(player->GetQuestStatus(Q_CHAMPION) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_CHAMPION))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            }
        }
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature), _Creature->GetGUID());
        return true;
    };

    bool OnGossipSelect(Player* player, Creature* _Creature, uint32 sender, uint32 action)
    {
        player->CLOSE_GOSSIP_MENU();
        switch(action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                if(AddItemToPlayer(player,I_SAGE))
                {
                    player->SetQuestStatus(Q_W_SAGE,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_W_SAGE].m_rewarded = false;
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                if(AddItemToPlayer(player,I_ETERNAL))
                {
                    player->SetQuestStatus(Q_W_ETERNAL,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_W_ETERNAL].m_rewarded = false;
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                if(AddItemToPlayer(player,I_DEFENDER))
                {
                    player->SetQuestStatus(Q_W_DEFENDER,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_W_DEFENDER].m_rewarded = false;
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                if(AddItemToPlayer(player,I_CHAMPION))
                {
                    player->SetQuestStatus(Q_W_CHAMPION,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_W_CHAMPION].m_rewarded = false;
                }
            break;
        }

        return true;
    };
};

/*######
## npc_anachronos  AQ40Ring
######*/

enum AQ40RingQuests
{
    Q_AQ40_PROTECTOR = 8751,
    Q_AQ4_CONQUEROR = 8756,
    Q_AQ4_INVOKER = 8761,

    Q_AQ4_W_PROTECTOR = 8764,
    Q_AQ4_W_CONQUEROR = 8766,
    Q_AQ4_W_INVOKER = 8765,
};

enum AQ40Rings
{
    I_AQ4_PROTECTOR = 21200,
    I_AQ4_CONQUEROR = 21205,
    I_AQ4_INVOKER = 21210,
};

class npc_anachronos : public CreatureScript
{
public:
    npc_anachronos() : CreatureScript("npc_anachronos") { }

    bool OnGoosipHello(Player* player, Creature* _Creature)
    {
        if (_Creature->isQuestGiver())
            player->PrepareQuestMenu( _Creature->GetGUID() );

        if( !(player->HasItemCount(I_AQ4_PROTECTOR,1,true) || player->HasItemCount(I_AQ4_CONQUEROR,1,true) ||
            player->HasItemCount(I_AQ4_INVOKER,1,true) ))
        {
            if(player->GetQuestStatus(Q_AQ40_PROTECTOR) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_AQ40_PROTECTOR))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            }else if(player->GetQuestStatus(Q_AQ4_CONQUEROR) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_AQ4_CONQUEROR))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            }else if(player->GetQuestStatus(Q_AQ4_INVOKER) == QUEST_STATUS_COMPLETE && player->GetQuestRewardStatus(Q_AQ4_INVOKER))
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_TEXT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            }
        }
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature), _Creature->GetGUID());
        return true;
    };

    bool OnGossipSelect(Player* player, Creature* _Creature, uint32 sender, uint32 action)
    {
        player->CLOSE_GOSSIP_MENU();
        switch(action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                if(AddItemToPlayer(player,I_AQ4_PROTECTOR))
                {
                    player->SetQuestStatus(Q_AQ4_W_PROTECTOR,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_AQ4_W_PROTECTOR].m_rewarded  = false;
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                if(AddItemToPlayer(player,I_AQ4_CONQUEROR))
                {
                    player->SetQuestStatus(Q_AQ4_W_CONQUEROR,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_AQ4_W_CONQUEROR].m_rewarded = false;
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                if(AddItemToPlayer(player,I_AQ4_INVOKER))
                {
                    player->SetQuestStatus(Q_AQ4_W_INVOKER,QUEST_STATUS_NONE);
                    //player->getQuestStatusMap()[Q_AQ4_W_INVOKER].m_rewarded = false;
                }
                break;
        }

        return true;
    };
};

/*######
## go_sacred_fire_life
######*/

#define N_ARIKARA       10882
#define Q_ARIKARA       5088

class go_sacred_fire_life : public GameObjectScript
{
public:
    go_sacred_fire_life() : GameObjectScript("go_sacred_fire_life") { }

    bool OnGossipHello(Player *player, GameObject* _GO)
    {
        if(player->GetQuestStatus(5088) == QUEST_STATUS_INCOMPLETE)
        {
            _GO->SummonCreature(N_ARIKARA,_GO->GetPositionX(),_GO->GetPositionY(),_GO->GetPositionZ(),0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,10000);
            return false;
        }
        return true;
    }
};

/*######
## go_panther_cage
######*/

#define N_ENRAGED_PANTHER   10992

class go_panther_prison : public GameObjectScript
{
public:
    go_panther_prison() : GameObjectScript("go_panther_prison") { }

bool OnGossipHello(Player *player, GameObject* _GO)
{
    {Creature* panth = GetClosestCreatureWithEntry(player,N_ENRAGED_PANTHER,50);
        if(panth)
        {
            panth->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_OOC_NOT_ATTACKABLE);
            panth->Attack(player,true);
            return false;
        }
    }
    return true;
}
};

/*######
## go_maghar_prison
######*/

#define N_MAG_PRIS      18428

class go_maghar_prison : public GameObjectScript
{
public:
    go_maghar_prison() : GameObjectScript("go_maghar_prison") { }

    bool OnGossipHello(Player *player, GameObject* _GO)
    {
            {Creature* mag = GetClosestCreatureWithEntry(player,N_MAG_PRIS,10);
            if(mag)
            {
                if(player->GetQuestStatus(9948) == QUEST_STATUS_INCOMPLETE)
                {
                    player->KilledMonsterCredit(N_MAG_PRIS,mag->GetGUID());
                    return false;
                }
            }
            }
            return true;
    }
};

/*######
## go_veil_skith_cage
######*/

#define N_CHILD         22314

class go_veil_skith_cage_1 : public GameObjectScript
{
public:
    go_veil_skith_cage_1() : GameObjectScript("go_veil_skith_cage_1") { }

    bool OnGossipHello(Player *player, GameObject* _GO)
    {
            {Creature* child = GetClosestCreatureWithEntry(player,N_CHILD,10);
            if(child)
            {
                if(player->GetQuestStatus(10852) == QUEST_STATUS_INCOMPLETE)
                {
                    player->KilledMonsterCredit(N_CHILD,child->GetGUID());
                    return false;
                }
            }
            }
            return true;
    }
};

class go_veil_skith_cage_2 : public GameObjectScript
{
public:
    go_veil_skith_cage_2() : GameObjectScript("go_veil_skith_cage_2") { }

    bool OnGossipHello(Player *player, GameObject* _GO)
    {
            {Creature* child = GetClosestCreatureWithEntry(player,N_CHILD,10);
            if(child)
            {
                if(player->GetQuestStatus(10852) == QUEST_STATUS_INCOMPLETE)
                {
                    player->KilledMonsterCredit(N_CHILD,child->GetGUID());
                    player->KilledMonsterCredit(N_CHILD,child->GetGUID());
                    return false;
                }
            }
            }
            return true;
    }
};

class go_veil_skith_cage_3 : public GameObjectScript
{
public:
    go_veil_skith_cage_3() : GameObjectScript("go_veil_skith_cage_3") { }

    bool OnGossipHello(Player *player, GameObject* _GO)
    {
            {Creature* child = GetClosestCreatureWithEntry(player,N_CHILD,10);
            if(child)
            {
                if(player->GetQuestStatus(10852) == QUEST_STATUS_INCOMPLETE)
                {
                    player->KilledMonsterCredit(N_CHILD,child->GetGUID());
                    player->KilledMonsterCredit(N_CHILD,child->GetGUID());
                    player->KilledMonsterCredit(N_CHILD,child->GetGUID());
                    return false;
                }
            }
            }
            return true;
    }
};

/*#####
# item_Warp-Attuned Orb
#####*/

#define N_NMARK             20333
#define N_SMARK             20337
#define N_WMARK             20338
#define N_OMARK             20336

class item_warp_orb : public ItemScript
{
public:
    item_warp_orb() : ItemScript("item_warp_orb") { }

    bool OnUse(Player *player, Item* _Item, SpellCastTargets const& targets)
    {
        if(player->GetQuestStatus(10313) == QUEST_STATUS_INCOMPLETE)
        {
            {Creature* quest1 = GetClosestCreatureWithEntry(player,N_NMARK,75);
             Creature* quest2 = GetClosestCreatureWithEntry(player,N_SMARK,75);
             Creature* quest3 = GetClosestCreatureWithEntry(player,N_WMARK,75);
             Creature* quest4 = GetClosestCreatureWithEntry(player,N_OMARK,75);
                if(quest1)
                {
                    player->KilledMonsterCredit(N_NMARK,quest1->GetGUID());
                    return false;
                }
                else if(quest2)
                {
                    player->KilledMonsterCredit(N_SMARK,quest2->GetGUID());
                    return false;
                }
                else if(quest3)
                {
                    player->KilledMonsterCredit(N_WMARK,quest3->GetGUID());
                    return false;
                }
                else if(quest4)
                {
                    player->KilledMonsterCredit(N_OMARK,quest4->GetGUID());
                    return false;
                }
                else
                {
                    player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW,_Item,NULL);
                    return true;
                }
            }
        }
        else
        {
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW,_Item,NULL);
            return true;
        }
    }
};

/*#####
# item_purification_rod
#####*/

#define N_QTARGET           22288
#define Q_DARKSTONE         10839
#define S_PURIFICATION_ROD  38736

class item_purification_rod : public ItemScript
{
public:
    item_purification_rod() : ItemScript("item_purification_rod") { }

    bool OnUse(Player *player, Item* _Item, SpellCastTargets const& targets)
    {
        {Creature* quest = GetClosestCreatureWithEntry(player,N_QTARGET,20);
            if(quest)
            {
                ((Player*)player)->GroupEventHappens(Q_DARKSTONE,quest);
                return false;
            }
            else
            {
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW,_Item,NULL);
            return true;
            }
        }
    }
};

/*#####
# item_rod_of_compulsion
#####*/

class item_rod_of_compulsion : public ItemScript
{
public:
    item_rod_of_compulsion() : ItemScript("item_rod_of_compulsion") { }

    bool OnUse(Player *player, Item* _Item, SpellCastTargets const& targets)
    {
        if(Unit *target = targets.getUnitTarget())
        {
            if(target->GetTypeId() == TYPEID_PLAYER || 
                (target->GetEntry() != 27237 && target->GetEntry() != 27235 &&  target->GetEntry() != 27234 &&  target->GetEntry() != 27236))
            {
                player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW,_Item,NULL);
                return true;
            }
            return false;
        }else
        {
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW,_Item,NULL);
            return true;
        }
    }
};

/*#####
# npc_totem_earthelemental
#####*/

/*SQL
UPDATE creature_template SET scriptname = 'npc_totem_earthelemental' WHERE entry = 15352;
*/

#define ENTRY_EARTH_ELEMENTAL_TOTEM     15430
#define SPELL_EARTH_ELEMENTAL_TAUNT     36213

class npc_totem_earthelemental : public CreatureScript
{
public:
    npc_totem_earthelemental() : CreatureScript("npc_totem_earthelemental") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new npc_totem_earthelementalAI (_Creature);
    }

    struct npc_totem_earthelementalAI : public Scripted_NoMovementAI
    {
        npc_totem_earthelementalAI(Creature* c) : Scripted_NoMovementAI(c)
        {
            Creature* totem = FindNearestCreature(ENTRY_EARTH_ELEMENTAL_TOTEM,5);
            if(totem)
                TotemGUID = totem->GetGUID();
            else TotemGUID = 0;
        }

        uint64 TotemGUID;
        uint32 TauntTimer;
        bool Kill;

        Creature* FindNearestCreature(uint32 entry, float range)
        {
            Creature* temp = GetClosestCreatureWithEntry(me,ENTRY_EARTH_ELEMENTAL_TOTEM,5,true);
            return temp;
        }

        void EnterCombat(Unit* who){}

        void Reset()
        {
            TauntTimer = rand()%5000 + 1000;
            Kill = false;
        }

        void UpdateAI(const uint32 diff)
        {
            if(me->isDead())
                return;

            if(TauntTimer <= diff)
            {
                DoCastAOE(SPELL_EARTH_ELEMENTAL_TAUNT);
                TauntTimer = rand()%5000 + 1000;
            }else TauntTimer -= diff;

            if(TotemGUID)
            {
                Creature* totem = Creature::GetCreature((*me),TotemGUID);
                if(!totem)
                    Kill = true;
            }else Kill = true;

            if(Kill)
            {
                me->DealDamage(me,me->GetHealth());
                me->RemoveCorpse();
                return;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*#####
# npc_wyrm_training_dummy
#####*/

#define SPELL_DUMMY_BANNER_ALLIANCE         61573
#define SPELL_DUMMY_BANNER_HORDE            61574

class npc_wyrm_training_dummy : public CreatureScript
{
public:
    npc_wyrm_training_dummy() : CreatureScript("npc_wyrm_training_dummy") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new npc_wyrm_training_dummyAI (_Creature);
    }

    struct  npc_wyrm_training_dummyAI : Scripted_NoMovementAI
    {
        npc_wyrm_training_dummyAI(Creature *c) : Scripted_NoMovementAI(c)
        {
            m_Entry = c->GetEntry();
        }

        uint32 m_Entry;
        uint32 ResetTimer;
        uint32 DespawnTimer;

        bool isInHordeArea()
        {
            switch(me->GetZoneId())
            {
                case 1497:
                case 1637:
                case 1638:
                case 3487:
                    return true;
            }
            return false;
        }

        void EnterEvadeMode()
        {
            if (!_EnterEvadeMode())
                return;

            Reset();
        }

        bool isInAcherus()
        { 
            return me->GetAreaId() == 4281 || me->GetMapId() == 609;
        }

        void Reset()
        {
            me->SetHomePosition(me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),me->GetOrientation());

            //me->SetControlled(true,UNIT_STAT_STUNNED);//disable rotate
            ResetTimer = 10000;
            DespawnTimer = 15000;

            if(!isInAcherus())
                me->CastSpell(me,isInHordeArea() ? SPELL_DUMMY_BANNER_ALLIANCE : SPELL_DUMMY_BANNER_HORDE , true);
        }

        void DamageTaken(Unit *done_by, uint32 &damage)
        {
            damage = 0;

            if(done_by->GetTypeId() != TYPEID_PLAYER && (done_by->GetTypeId() != TYPEID_UNIT || ( !done_by->isGuardian() && !done_by->isPet())))
                return;

            ResetTimer = 10000;
        }

        void EnterCombat(Unit *who)
        {
            if (m_Entry != 2674 && m_Entry != 2673)
                return;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (m_Entry != 2674 && m_Entry != 2673)
            {
                if (ResetTimer <= diff)
                {
                    EnterEvadeMode();
                    ResetTimer = 10000;
                    return;
                }else  ResetTimer -= diff;
            }
            else
            {
                if (DespawnTimer <= diff)
                    me->DespawnOrUnsummon();
                else
                    DespawnTimer -= diff;
            }
        }
        void MoveInLineOfSight(Unit *who) { return; }
    };
};

/*#####
# npc_azaloth
#####*/

#define ENTRY_SUNFURY_WARLOCK           21503
#define ENTRY_AZALOTH_CREDIT            21892

#define SPELL_UNBANISH                  37834
#define SPELL_SPELLBIND_AZALOTH         38722

#define SPELL_AZALOTH_CLEAVE            40504
#define SPELL_AZALOTH_WARSTOMP          38750
#define SPELL_AZALOTH_RAINOFFIRE        38741
#define SPELL_AZALOTH_CRIPPLE           11443

class npc_azaloth : public CreatureScript
{
public:
    npc_azaloth() : CreatureScript("npc_azaloth") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new npc_azalothAI (_Creature);
    }

    struct  npc_azalothAI : ScriptedAI
    {
        npc_azalothAI(Creature *c) : ScriptedAI(c)
        {
            isBanished = true;
        }

        bool isBanished;
        uint32 Banish_Timer;

        uint32 Cleave_Timer;
        uint32 Warstomp_Timer;
        uint32 RainOfFire_Timer;
        uint32 Cripple_Timer;

        void Reset()
        {
            Banish_Timer = 30000;

            Cleave_Timer = 5000;
            Warstomp_Timer = 10000;
            RainOfFire_Timer = 15000;
            Cripple_Timer = 15000;
        }

        void EnterCombat(Unit *who)
        {
            if(!isBanished) me->RemoveAllAuras();
        }

        void DamageTaken(Unit *pDone_by, uint32 &uiDamage)
        {
            if(isBanished) uiDamage = 0;
        }

        void SpellHit(Unit *caster, const SpellEntry *spell)
        {
            if(!isBanished)
                return;

            if(spell->Id == SPELL_UNBANISH)
            {
                if(caster->GetTypeId() == TYPEID_PLAYER)
                    ((Player*)caster)->CastedCreatureOrGO(ENTRY_AZALOTH_CREDIT,me->GetGUID(),SPELL_UNBANISH);
                isBanished = false;
            }
        }

        void AttackStart(Unit *who)
        {
            if(!isBanished)
                ScriptedAI::AttackStart(who);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!isBanished)
            {
                if(Banish_Timer <= diff)
                {
                    std::list<Creature*> list;
                    GetCreatureListWithEntryInGrid(list,me,ENTRY_SUNFURY_WARLOCK,20.0f);

                    for (std::list<Creature*>::iterator iter = list.begin(); iter != list.end(); ++iter)
                    {
                        Creature *c = *iter;
                        if (c)
                        {
                            if(c->isDead())
                            {
                                c->Respawn(true);
                                c->CastSpell(me,SPELL_SPELLBIND_AZALOTH,true);
                            }
                        }
                    }
                    isBanished = true;
                    Banish_Timer = 30000;
                }else Banish_Timer -= diff;
            }

            if (!UpdateVictim())
                return;

            if(Cleave_Timer <= diff)
            {
                DoCast(me->getVictim(),SPELL_AZALOTH_CLEAVE);
                Cleave_Timer = 10000;
            }else Cleave_Timer -= diff;

            if(Warstomp_Timer <= diff)
            {
                DoCast(me,SPELL_AZALOTH_WARSTOMP);
                Warstomp_Timer = 15000;
            }else Warstomp_Timer -= diff;

            if(RainOfFire_Timer <= diff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(pTarget,SPELL_AZALOTH_RAINOFFIRE);
                RainOfFire_Timer = 20000;
            }else RainOfFire_Timer -= diff;

            if(Cripple_Timer <= diff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(pTarget,SPELL_AZALOTH_CRIPPLE);
                Cripple_Timer = 10000;
            }else Cripple_Timer -= diff;

            DoMeleeAttackIfReady();

            Banish_Timer = 30000;
        }
    };
};

/*#####
# mob_onyxian_whelpling
#####*/

#define SPELL_ONYXIAN_WHELPLING_BREATH              69004
#define SPELL_ONYXIAN_WHELPLING_TRGGER              69005
#define SPELL_ONYXIAN_WHELPLING_STUNN               69006

class mob_onyxian_whelpling : public CreatureScript
{
public:
    mob_onyxian_whelpling() : CreatureScript("mob_onyxian_whelpling") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_onyxian_whelplingAI (_Creature);
    }

    struct mob_onyxian_whelplingAI : public ScriptedAI
    {
        mob_onyxian_whelplingAI(Creature *c) : ScriptedAI(c) {Reset();}
        bool breath;
        void Reset()
        {
            breath = false;
            me->CastSpell(me,SPELL_ONYXIAN_WHELPLING_TRGGER,true);
            if (Unit* own = me->GetOwner())
                me->GetMotionMaster()->MoveFollow(own,PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
        }
        void Aggro(Unit *who){}

        void SpellHit(Unit *caster, const SpellEntry *spell)
        {
            if(caster->GetGUID() != me->GetGUID())
                return;

            if(spell->Id == SPELL_ONYXIAN_WHELPLING_STUNN)
            {
                me->MonsterTextEmote("%s takes in a deep breath...",me->GetGUID());
                breath = true;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(breath)
            {
                if(!me->HasUnitState(UNIT_STAT_STUNNED))
                {
                    me->CastSpell(me,SPELL_ONYXIAN_WHELPLING_BREATH,false);
                    breath = false;
                }
            }
        }
    };
};

/*#####
# mob_companion_pet
#####*/

#define SPELL_KIRINTOR_FAMILAR                      61478
#define ENTRY_KIRIN_TOR_FAMILAR                     32643

class mob_companion_pet : public CreatureScript
{
public:
    mob_companion_pet() : CreatureScript("mob_companion_pet") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new mob_companion_petAI (_Creature);
    }

    struct mob_companion_petAI : public ScriptedAI
    {
        mob_companion_petAI(Creature *c) : ScriptedAI(c) {Reset();}
        void Reset()
        {
            switch(me->GetEntry())
            {
            case ENTRY_KIRIN_TOR_FAMILAR:
                me->CastSpell(me,SPELL_KIRINTOR_FAMILAR,true);
                break;
            }
            if (Unit* own = me->GetOwner())
                me->GetMotionMaster()->MoveFollow(own,PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
        }
        void Aggro(Unit *who){}
        void UpdateAI(const uint32 diff){}
    };
};

/*######
## npc_night_elf_mohawk
######*/

#define SPELL_CREATE_MOHAWK_GRANADE             69243
#define ITEM_MOHAWK_GRENADE                     43489

class npc_night_elf_mohawk : public CreatureScript
{
public:
    npc_night_elf_mohawk() : CreatureScript("npc_night_elf_mohawk") { }

    bool OnGossipHello(Player *player, Creature *_Creature)
    {
        if(!player->HasItemCount(ITEM_MOHAWK_GRENADE,1,true))
            player->ADD_GOSSIP_ITEM(0,"I pity the fools.",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1);
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature),_Creature->GetGUID());
        return true; 
    }

    bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action )
    {
        player->CLOSE_GOSSIP_MENU();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            _Creature->CastSpell(player,SPELL_CREATE_MOHAWK_GRANADE,false);
        }
        return true;
    }
};

/*######
## vehicle_wyrm_default
######*/

enum VehicleNpcEntrys
{
    ENTRY_ARGENT_SKYTALON               = 30228,
    ENTRY_WYRMREST_VANQUISHER           = 27996
};

enum VehicleDefaultSpells
{
    SPELL_ARGENT_SKYTALON_FLIGHT        = 56682,
    SPELL_WYRMREST_VANQUISHER_FLIGHT    = 50345
};

/* SQL:
UPDATE creature_template SET ScriptName = 'vehicle_wyrm_default' WHERE entry = 30228; -- Argent Skytalion
UPDATE creature_template SET ScriptName = 'vehicle_wyrm_default' WHERE entry = 27996; -- Wyrmrest Vanquisher
*/

class vehicle_wyrm_default : public CreatureScript
{
public:
    vehicle_wyrm_default() : CreatureScript("vehicle_wyrm_default") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new  vehicle_wyrm_defaultAI(_Creature);
    }

    struct vehicle_wyrm_defaultAI : public VehicleAI
    {
        vehicle_wyrm_defaultAI(Creature *c) : VehicleAI(c) { }

        void Reset()
        {
            VehicleAI::Reset();

            switch(me->GetEntry())
            {
            case ENTRY_ARGENT_SKYTALON:
                me->AddAura(SPELL_ARGENT_SKYTALON_FLIGHT,me);
                break;
            case ENTRY_WYRMREST_VANQUISHER:
                me->AddAura(SPELL_WYRMREST_VANQUISHER_FLIGHT,me);
                break;
            }
        }

        void JustRespawned()
        {
            VehicleAI::JustRespawned();
        }

        void OnCharmed(bool apply)
        {
            VehicleAI::OnCharmed(apply);
        }

        void UpdateAI(const uint32 diff)
        {
            VehicleAI::UpdateAI(diff);
        }
    };

};

class npc_item_quest_giver : public CreatureScript
{
public:
    npc_item_quest_giver() : CreatureScript("npc_item_quest_giver") { }

    bool OnGossipHello(Player *player, Creature *_Creature)
    {
        if (_Creature->isQuestGiver())
            player->PrepareQuestMenu(_Creature->GetGUID());

        if( _Creature->isVendor() )
            player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        if( _Creature->isTrainer() )
            player->ADD_GOSSIP_ITEM(3, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);
        
        for (QuestStatusMap::const_iterator itr = player->getQuestStatusMap().begin(); itr != player->getQuestStatusMap().end(); ++itr)
        {
            //if(itr->second.m_rewarded)
            //    continue;
                
            uint32 itemid = getItemID(itr->first);
            if(!itemid)
                continue;
            
            if(!_Creature->hasQuest(itr->first))
                continue;
            
            if(player->HasItemCount(itemid, 1, true))
                continue;
            
            LocaleConstant locale = player->GetSession()->GetSessionDbLocaleIndex();
            
            std::string itemName;
            const ItemLocale *itemLocale = sObjectMgr->GetItemLocale(itemid);
            if(itemLocale)
            {
                sObjectMgr->GetLocaleString(itemLocale->Name, locale, itemName);
            }
            
            if(!itemName.size())
            {   
                const ItemPrototype *item = sObjectMgr->GetItemPrototype(itemid);
                if(!item)
                    continue;
                
                itemName = item->Name1;
            }
            
            std::ostringstream ss;
            ss << "Ich habe den Gegenstand \"";
            ss << itemName;
            ss << "\" verloren, könnte ich ihn bitte wieder haben?";
            
            player->ADD_GOSSIP_ITEM(0, ss.str().c_str(),GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+itemid);
        }
        
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature),_Creature->GetGUID());
        return true; 
    }

    bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action )
    {
        if (action > GOSSIP_ACTION_INFO_DEF)
        {            
            player->CLOSE_GOSSIP_MENU();
            
            player->AddItem(action - GOSSIP_ACTION_INFO_DEF, 1);
        }
        return true;
    }
    
private:
    uint32 getItemID(uint32 quest)
    {
        switch(quest)
        {
            case 12529: return 38619;
            default:    return 0;
        }
    }
};

class global_chatticker_playerscript : PlayerScript
{
public:
    global_chatticker_playerscript() : PlayerScript("global_chatticker_playerscript")
    {
        channelName = sConfig->GetStringDefault("Chatticker.Channel", "global");
    }
    
    void OnChat(Player* player, uint32 type, uint32 lang, std::string& message, Channel* channel)
    {
        if(player && !stricmp(channel->GetName().c_str(), channelName.c_str()))
        {
            std::string stripped = message;   // create private copy
            
            stripLinks(stripped);
            
            PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_ADD_CHATTICKER_MESSAGE);
            stmt->setString(0, player->GetName());
            stmt->setUInt8(1, player->getRace());
            stmt->setString(2, stripped);
            CharacterDatabase.Execute(stmt);
        }
    }
private:
    std::string channelName;
    
    
    // link format: |c<color code>|H<type>:<id>[:<parameter>[:<parameter>]]|h[<name>]|h|r
    void stripLinks(std::string& message)
    {
        while(true)
        {
            std::string::size_type startPosLink = message.find("|c");
            if(startPosLink == message.npos)
                return;
            
            std::string::size_type startPosName = message.find("|h", startPosLink + 2);
            if(startPosName == message.npos)
                return;
            
            std::string::size_type endPos       = message.find("|h|r", startPosName + 2);
            if(endPos == message.npos)
                return;
            
            message.erase(endPos, 4);
            message.erase(startPosLink, startPosName - startPosLink + 2);
        }
    }
};

#include "ScriptPCH.h"

/*######
## npc_wyrm_debug_repairbot
######*/

#define GOSSIP_REPAIR               "Repariere meine Ausruestung."
#define GOSSIP_REPAIR_DEAK          "Reparieren deaktiveren"
#define GOSSIP_REPAIR_AKTI          "Reparieren aktivieren"

// Sunwell
#define GOSSIP_SUNWELL_START        "Bringe mich zum Eingang zurueck."
#define GOSSIP_SUNWELL_KALEG        "Teleportiere mich vor Kalecgos."
#define GOSSIP_SUNWELL_BRUT         "Teleportiere mich vor Brutallus Felmyst."
#define GOSSIP_SUNWELL_TWINS        "Teleportiere mich zu den Eredar twins."
#define GOSSIP_SUNWELL_MURU         "Teleportiere mich zu Muru."
#define GOSSIP_SUNWELL_KIL          "Teleportiere mich zu KilJaden"

// Ulduar
#define GOSSIP_ULDUAR_BASE_CAMP     "Teleportiere mich zum Expedition Base Camp (Start)"
#define GOSSIP_ULDUAR_GROUNDS       "Teleportiere mich zu Formation Grounds (vor Flame Leviathan)"
#define GOSSIP_ULDUAR_FORGE         "Teleportiere mich zur Colossal Forge (Ignis/Racorscale)"
#define GOSSIP_ULDUAR_SCRAPYARD     "Teleportiere mich zum Scrapyard (hinter XT_002)"
#define GOSSIP_ULDUAR_ANTECHAMBER   "Teleportiere mich zur Antechamber of Ulduar (Assembly of Iron)"
#define GOSSIP_ULDUAR_WALKWAY       "Teleportiere mich zum Shattered Walkway (hinter Kologarn)"
#define GOSSIP_ULDUAR_CONSERVATORY  "Teleportiere mich zum the Conservatory of Life (Freya)"
#define GOSSIP_ULDUAR_SPARK         "Teleportiere mich zum the Spark of Imagination (Mimiron)"
#define GOSSIP_ULDUAR_VEZAX         "Teleportiere mich zum General Vezax (Vezax)"
#define GOSSIP_ULDUAR_MADNESS       "Teleportiere mich zur the Descent into Madness (YoggSaron)"

enum GOSSIP_REPAIRBOT
{
    REPARATUR = 1,
    DEAK_REPAIR = 2,
    AKTI_REPAIR = 3,

    TELE_SUNWELL = 10,
    TELE_SUNWELL_KALEG = 11,
    TELE_SUNWELL_BRUT = 12,
    TELE_SUNWELL_TWINS = 13,
    TELE_SUNWELL_MURU = 14,
    TELE_SUNWELL_KIL = 15,
    TELE_SUNWELL_START = 16,
    TELE_SUNWELL_MAX = 19,

    TELE_ULDUAR = 20,
    TELE_ULDUAR_BASE_CAMP = 21,
    TELE_ULDUAR_GROUNDS = 22,
    TELE_ULDUAR_FORGE = 23,
    TELE_ULDUAR_SCRAPYARD = 24,
    TELE_ULDUAR_ANTECHAMBER = 25,
    TELE_ULDUAR_WALKWAY = 26,
    TELE_ULDUAR_CONSERVATORY = 27,
    TELE_ULDUAR_SPARK = 28,
    TELE_ULDUAR_VEZAX   = 29,
    TELE_ULDUAR_MADNESS = 30,
    TELE_ULDUAR_MAX = 31,
};

enum MAPS
{
    MAP_SUNWELL     = 580,
    MAP_ULDUAR      = 603,
};

float TeleportPointsSunwell[6][3] = 
{
    {1744,  920, 16},// Start
    {1700, 1052, 53},// Kalecgos
    {1554,  645, 51},// Brutallus Fellmyst
    {1822,  688, 33},// Eredar Twins
    {1878,  566, 72},// Muru
    {1649,  553, 34},// KilJaden
};

float TeleportPointsUlduar[10][3] =
{
    {-706.122f, -92.6024f, 429.876f}, // Base Camp
    {131.248f, -35.3802f, 409.804f}, // Grounds
    {553.233f, -12.3247f, 409.679f}, // Forge
    {926.292f, -11.4635f, 418.595f}, //Scrapyard
    {1498.09f, -24.246f, 420.967f}, // Antechamber
    {1859.45f, -24.1f, 448.9f}, // Walkway
    {2086.27f, -24.3134f, 421.239f}, // Conservatory
    {2518.13f, 2569.34f, 421.382f}, // Spark
    {1824.34f, 202.16f, 358.0f}, // General Vezax
    {1855.03f, -11.629f, 334.58f}, //Descent into Madness
};

class npc_wyrm_debug_repairbot : public CreatureScript
{
public:
    npc_wyrm_debug_repairbot() : CreatureScript("npc_wyrm_debug_repairbot") { }

    // Infos zur Gossip Symbol
    // 0 -  Sprechblase
    // 1 -  Geldsack
    // 2 -  Sieht aus wie eine Feder -> Flugmeister?
    // 3 -  Buch -> Lernen
    // 4 -  Zahnrad -> ???
    // 5 -  Zahnrad -> ???
    // 6 -  Geldsack
    // 7 -  Sprechblase mit 3 Punkte
    // 8 -  Tarbat Zeichen (Wappenrock)
    // 9 -  2 Gekräutzte Schwerter
    // 10 - 1 Gelber Punkt
    // Nicht mehr als 10 eingeben

    bool OnGossipHello(Player* player, Creature* _Creature)
    {
        InstanceScript* pInstance = _Creature->GetInstanceScript();

        if(pInstance)
        {
            //repair
            if(player->isGameMaster())
            {
                //if( pInstance->GetData(DATA_REPAIR_BOT_STATE) == 1)
                //    player->ADD_GOSSIP_ITEM(4, GOSSIP_REPAIR_DEAK, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + DEAK_REPAIR);
                //else
                //    player->ADD_GOSSIP_ITEM(4, GOSSIP_REPAIR_AKTI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + AKTI_REPAIR);
            }

            //if(pInstance->GetData(DATA_REPAIR_BOT_STATE) == 1)
            //    player->ADD_GOSSIP_ITEM(4, GOSSIP_REPAIR, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + REPARATUR);

            switch(_Creature->GetMapId())
            {
                case MAP_SUNWELL:
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SUNWELL_START, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_START);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SUNWELL_KALEG, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_KALEG);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SUNWELL_BRUT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_BRUT);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SUNWELL_TWINS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_TWINS);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SUNWELL_MURU, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_MURU);
                    //player->ADD_GOSSIP_ITEM(0, GOSSIP_SUNWELL_KIL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_KIL);
                }
                case MAP_ULDUAR:
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_BASE_CAMP, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_BASE_CAMP);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_GROUNDS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_GROUNDS);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_FORGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_FORGE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_SCRAPYARD, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_SCRAPYARD);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_ANTECHAMBER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_ANTECHAMBER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_WALKWAY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_WALKWAY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_CONSERVATORY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_CONSERVATORY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_SPARK, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_SPARK);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_VEZAX, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_VEZAX);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ULDUAR_MADNESS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_MADNESS);
                }
            }
        }

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature), _Creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* _Creature, uint32 sender, uint32 action)
    {
        player->CLOSE_GOSSIP_MENU();
        if(action < 10)
            switch(action)
            {
                case GOSSIP_ACTION_INFO_DEF + REPARATUR:
                {
                    player->DurabilityRepairAll(false,0,false);
                    _Creature->MonsterWhisper("Reparatur Job erledigt. *biep*",player->GetGUID());
                }
                break;
                case GOSSIP_ACTION_INFO_DEF + DEAK_REPAIR:
                {
                    InstanceScript* pInstance = _Creature->GetInstanceScript();

                    //if(pInstance && player->isGameMaster())
                    //{
                    //    pInstance->SetData(DATA_REPAIR_BOT_STATE,0);
                    //    _Creature->MonsterWhisper("Reparaturmodus deaktiviert. *biep*",player->GetGUID());
                    //}

                }
                break;
                case GOSSIP_ACTION_INFO_DEF + AKTI_REPAIR:
                {
                    InstanceScript* pInstance = _Creature->GetInstanceScript();

                    //if(pInstance && player->isGameMaster())
                    //{
                    //    pInstance->SetData(DATA_REPAIR_BOT_STATE,1);
                    //    _Creature->MonsterWhisper("Reparaturmodus deaktiviert. *biep*",player->GetGUID());
                    //}
                }
                break;
            }

        if(_Creature->GetMapId() == MAP_SUNWELL && action-GOSSIP_ACTION_INFO_DEF > TELE_SUNWELL && action-GOSSIP_ACTION_INFO_DEF < TELE_SUNWELL_MAX)
            switch(action)
            {
                case GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_START: player->TeleportTo(MAP_SUNWELL, TeleportPointsSunwell[0][0],TeleportPointsSunwell[0][1],TeleportPointsSunwell[0][2],0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_KALEG: player->TeleportTo(MAP_SUNWELL, TeleportPointsSunwell[1][0],TeleportPointsSunwell[1][1],TeleportPointsSunwell[1][2],0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_BRUT:  player->TeleportTo(MAP_SUNWELL, TeleportPointsSunwell[2][0],TeleportPointsSunwell[2][1],TeleportPointsSunwell[2][2],0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_TWINS: player->TeleportTo(MAP_SUNWELL, TeleportPointsSunwell[3][0],TeleportPointsSunwell[3][1],TeleportPointsSunwell[3][2],0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_MURU:  player->TeleportTo(MAP_SUNWELL, TeleportPointsSunwell[4][0],TeleportPointsSunwell[4][1],TeleportPointsSunwell[4][2],0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_SUNWELL_KIL:   player->TeleportTo(MAP_SUNWELL, TeleportPointsSunwell[5][0],TeleportPointsSunwell[5][1],TeleportPointsSunwell[5][2],0.0f); break;
            }

        if(_Creature->GetMapId() == MAP_ULDUAR && action-GOSSIP_ACTION_INFO_DEF > TELE_ULDUAR && action-GOSSIP_ACTION_INFO_DEF < TELE_ULDUAR_MAX)
            switch(action)
            {
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_BASE_CAMP: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[0][0],TeleportPointsUlduar[0][1],TeleportPointsUlduar[0][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_GROUNDS: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[1][0],TeleportPointsUlduar[1][1],TeleportPointsUlduar[1][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_FORGE: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[2][0],TeleportPointsUlduar[2][1],TeleportPointsUlduar[2][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_SCRAPYARD: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[3][0],TeleportPointsUlduar[3][1],TeleportPointsUlduar[3][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_ANTECHAMBER: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[4][0],TeleportPointsUlduar[4][1],TeleportPointsUlduar[4][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_WALKWAY: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[5][0],TeleportPointsUlduar[5][1],TeleportPointsUlduar[5][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_CONSERVATORY: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[6][0],TeleportPointsUlduar[6][1],TeleportPointsUlduar[6][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_SPARK: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[7][0],TeleportPointsUlduar[7][1],TeleportPointsUlduar[7][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_VEZAX: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[8][0],TeleportPointsUlduar[8][1],TeleportPointsUlduar[8][2], 0.0f); break;
                case GOSSIP_ACTION_INFO_DEF + TELE_ULDUAR_MADNESS: player->TeleportTo(MAP_ULDUAR, TeleportPointsUlduar[9][0],TeleportPointsUlduar[9][1],TeleportPointsUlduar[9][2], 0.0f); break;
            }

        return true;
    }
};

void AddSC_lol_custom()
{
    new mob_arcane_sentries();
    new item_wyrm_attuned_crystal_cores();
    new mob_wyrm_dragonmaw_peon();
    new mob_felblood_initiate();
    new mob_emissary_of_hate();
    new mob_shattrath_banish();
    new npc_dragonmaw_illusion();
    new mob_living_flare();
    new mob_incandescent_fel_spark();
    new mob_flymaster();
    new npc_hellfire_smith();
    new npc_adal();
    new mob_bomb_target();
    new mob_bombingrun_target();
    new mob_masskill_target();
    new mob_doomguard_commander();
    new mob_null_creature();
    new npc_wyrm_greengill_slave();
    new npc_archmage_leryda();
    new npc_soridormi();
    new npc_anachronos();
    new go_maghar_prison();
    new go_veil_skith_cage_1();
    new go_veil_skith_cage_2();
    new go_veil_skith_cage_3();
    new go_panther_prison();
    new go_sacred_fire_life();
    new item_purification_rod();
    new item_rod_of_compulsion(); //UPDATE item_template SET ScriptName = 'item_rod_of_compulsion' WHERE entry = 37438;
    new item_warp_orb();
    new npc_totem_earthelemental();
    new npc_wyrm_training_dummy();
    new npc_azaloth(); //UPDATE creature_template SET scriptname = 'npc_azaloth' WHERE entry = 21506;
    new mob_onyxian_whelpling(); //UPDATE creature_template SET scriptname = 'mob_onyxian_whelpling' WHERE entry = 36607;
    new mob_companion_pet(); //UPDATE creature_template SET scriptname = 'mob_companion_pet' WHERE entry = 32643;
    new npc_night_elf_mohawk(); //UPDATE creature_template SET scriptname = 'npc_night_elf_mohawk' WHERE entry = 31111;
    new vehicle_wyrm_default();
    new npc_item_quest_giver();
    new npc_wyrm_debug_repairbot();

    if(sConfig->GetBoolDefault("Chatticker.Enabled", false))
        new global_chatticker_playerscript();
}
