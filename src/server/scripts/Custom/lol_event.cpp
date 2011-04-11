#include "ScriptPCH.h"
#include "Group.h"
/**********************************
Incense for the Summer Scorchlings
***********************************/

#define SAY_PART_1  "Thank you again, $N, for this delectable incense."
#define SAY_PART_2  "devours the incense. It's ravenous!" // EMote
#define SAY_PART_3  "So good! So packed with energy!"
#define SAY_PART_4  "It has everything a growing scorchling needs!"
#define SAY_PART_5  "I can feel the power SURGING within me!"
#define SAY_PART_6  "bellows with laughter!" //Emote
#define SAY_PART_7  "Now! Finally! Our plans can take effect!"
#define SAY_PART_8  "KNEEL, LITTLE MORTAL! KNEEL BEFORE THE MIGHT OF THE HERALD OF RAGNAROS!"
#define SAY_PART_9  "YOU WILL ALL PERISH IN FLAMES!"
#define SAY_PART_10 "blinks..." //Emote
#define SAY_PART_11 "Ah. I was merely jesting..."

#define SPELL_GROW  47114
#define ENTRY_WISP  26502

class npc_midsummer_scorchling : public CreatureScript
{
public:
    npc_midsummer_scorchling() : CreatureScript("npc_midsummer_scorchling") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new npc_midsummer_scorchlingAI (_Creature);
    }

    struct npc_midsummer_scorchlingAI : public ScriptedAI
    {
        npc_midsummer_scorchlingAI(Creature *c) : ScriptedAI(c)
        {
            Reset();
        }

        uint64 EventStarter;
        bool EventStarted;
        uint32 part;

        uint32 part_timer;

        void Reset()
        {
            EventStarter = 0;
            EventStarted = false;
            me->SetUInt32Value(UNIT_NPC_FLAGS, 3);
        }

        void MoveInLineOfSight(Unit *who)
        {
            //if(who->GetTypeId() == TYPEID_PLAYER)
            //{
            //    if(me->IsWithinDistInMap(who,20))
            //    {
            //        if( ((Player*)who)->GetQuestStatus(11964) == QUEST_STATUS_INCOMPLETE )
            //            ((Player*)who)->AreaExploredOrEventHappens(11964);

            //        if( ((Player*)who)->GetQuestStatus(11966) == QUEST_STATUS_INCOMPLETE )
            //            ((Player*)who)->AreaExploredOrEventHappens(11966);
            //    }
            //}
        }

        void StartEvent(Player* starter)
        {
            starter->DestroyItemCount(35725, 1, true);
            EventStarted = true;
            part = 0;
            EventStarter = starter->GetGUID();
            me->SetUInt32Value(UNIT_NPC_FLAGS, 0);

            part_timer = 0;
        }

        void SayPart(uint32 part)
        {
            switch(part)
            {
            case 1:
                me->MonsterSay(SAY_PART_1,LANG_UNIVERSAL,EventStarter);
                part_timer = 2000;
                break;
            case 2:
                me->MonsterTextEmote(SAY_PART_2,NULL,false);
                part_timer = 1000;
                break;
            case 3:
                me->MonsterSay(SAY_PART_3,LANG_UNIVERSAL, NULL );
                part_timer = 2500;
                break;
            case 4:
                me->MonsterSay(SAY_PART_4,LANG_UNIVERSAL, NULL );
                part_timer = 2500;
                break;
            case 5:
                me->MonsterSay(SAY_PART_5,LANG_UNIVERSAL, NULL );
                part_timer = 2500;
                break;
            case 6:
                me->MonsterTextEmote(SAY_PART_6,NULL,false);
                part_timer = 500;
                break;
            case 7:
                me->MonsterSay(SAY_PART_7,LANG_UNIVERSAL, NULL );
                part_timer = 2500;
                break;
            case 8:
                float x,y,z;
                me->GetPosition(x,y,z);
                DoSpawnCreature(ENTRY_WISP,0,0,0,me->GetOrientation(),TEMPSUMMON_TIMED_DESPAWN,5000);
                me->MonsterYell(SAY_PART_8,LANG_UNIVERSAL, NULL );
                part_timer = 2500;
                break;
            case 9:
                me->MonsterYell(SAY_PART_9,LANG_UNIVERSAL, NULL );
                part_timer = 2500;
                break;
            case 10:
                me->MonsterTextEmote(SAY_PART_10,NULL,false);
                me->RemoveAurasDueToSpell(SPELL_GROW);
                part_timer = 2000;
                break;
            case 11:
                me->MonsterSay(SAY_PART_11,LANG_UNIVERSAL, NULL);

                if(Player* player = Unit::GetPlayer(*me, EventStarter))
                {

                    if( player->GetQuestStatus(11964) == QUEST_STATUS_INCOMPLETE )
                        player->AreaExploredOrEventHappens(11964);

                    if( player->GetQuestStatus(11966) == QUEST_STATUS_INCOMPLETE )
                        player->AreaExploredOrEventHappens(11966);
                }

                part_timer = 9999000;
                return;
            }
        }


        void EnterCombat(Unit *who) { }
        void UpdateAI(const uint32 diff)
        {
            if(EventStarted)
            {
                if(part_timer <= diff)
                {
                    SayPart(part);

                    if( part > 1 && part < 8)
                    {
                        DoCast(me,SPELL_GROW,true);
                    }

                    part++;

                    if( part > 11)
                    {
                        Reset();
                        return;
                    }
                }else part_timer -= diff;
            }

            if (!UpdateVictim() )
                return;

            me->AI()->EnterEvadeMode();
        }
    };

    bool OnQuestComplete(Player *player, Creature *_Creature, const Quest *_Quest)
    {
        if(_Quest->GetQuestId() == 11964 || _Quest->GetQuestId() == 11966)
            CAST_AI(npc_midsummer_scorchling::npc_midsummer_scorchlingAI,_Creature->AI())->StartEvent(player);

        return true;
    }

    // Only for Testing
    #define OPTION      "Feed the Scorchling"

    bool OnGossipHello(Player *player, Creature *_Creature)
    {
        if (_Creature->isQuestGiver())
            player->PrepareQuestMenu( _Creature->GetGUID() );

        if ( player->HasItemCount(35725,1) && (player->GetQuestStatus(11964) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(11966) == QUEST_STATUS_INCOMPLETE ))
            player->ADD_GOSSIP_ITEM( 0, OPTION, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature),_Creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action)
    {
            if(action == GOSSIP_ACTION_INFO_DEF+1)
            {
                player->CLOSE_GOSSIP_MENU();
                CAST_AI(npc_midsummer_scorchling::npc_midsummer_scorchlingAI,_Creature->AI())->StartEvent(player);
            }

        return true;
    }
};

/********************
An Innocent Disguise
*********************/

#define QUEST_INNCOENT_DISGUISE         11891
#define SPELL_DISGUISE                  46337

#define SAY_DIALOG_1            "These stones should be the last of them. Our coordination with Neptulon's forces will be impeccable." //Briatha
#define SAY_DIALOG_2            "Yess. The Tidehunter will be pleased at this development. The Firelord's hold will weaken." //Emissary
#define SAY_DIALOG_3            "And your own preparations? Will the Frost Lord have a path to the portal?" //Briatha
#define SAY_DIALOG_4            "Skar'this has informed us well. We have worked our way into the slave pens and await your cryomancerss." //Emissary
#define SAY_DIALOG_5            "The ritual in Coilfang will bring Ahune through once he is fully prepared, and the resulting clash between Firelord and Frostlord will rend the foundations of this world. Our ultimate goals are in reach at last...." //Briatha

class npc_ice_caller_briatha : public CreatureScript
{
public:
	npc_ice_caller_briatha() : CreatureScript("npc_ice_caller_briatha") { }

	CreatureAI* GetAI(Creature *_Creature) const
	{
	    return new npc_ice_caller_briathaAI (_Creature);
	}

struct npc_ice_caller_briathaAI : public ScriptedAI
{
    npc_ice_caller_briathaAI(Creature *c) : ScriptedAI(c)
    {
        Reset();
    }

    uint64 EventStarter;
    bool EventStarted;
    uint32 part;

    uint32 part_timer;

    void Reset()
    {
        EventStarter = 0;
        EventStarted = false;
    }

    void MoveInLineOfSight(Unit *who)
    {
            if(!EventStarted && who->GetTypeId() == TYPEID_PLAYER)
                if(me->IsWithinDistInMap(who,20) && who->HasAura(SPELL_DISGUISE,1) && ((Player*)who)->GetQuestStatus(QUEST_INNCOENT_DISGUISE) == QUEST_STATUS_INCOMPLETE )
                    StartEvent(((Player*)who));
    }

    void StartEvent(Player* starter)
    {
        EventStarted = true;
        part = 1;
        EventStarter = starter->GetGUID();

        part_timer = 0;
    }

    void SayPart(uint32 part)
    {
        switch(part)
        {
        case 1:
            me->MonsterSay(SAY_DIALOG_1,LANG_UNIVERSAL,EventStarter);
            part_timer = 5000;
            break;
        case 2:
            if(Creature* emmissary = GetClosestCreatureWithEntry(me,25951,30))
            {
                emmissary->MonsterSay(SAY_DIALOG_2,LANG_UNIVERSAL, NULL );
            }
            part_timer = 5000;
            break;
        case 3:
            me->MonsterSay(SAY_DIALOG_3,LANG_UNIVERSAL, NULL );
            part_timer = 5000;
            break;
        case 4:
            if(Creature* emmissary = GetClosestCreatureWithEntry(me,25951,30))
            {
                emmissary->MonsterSay(SAY_DIALOG_4,LANG_UNIVERSAL, NULL );
            }
            part_timer = 5000;
            break;
        case 5:
            me->MonsterSay(SAY_DIALOG_5,LANG_UNIVERSAL, NULL );
            part_timer = 10000;
            break;
        case 6:
            if(Player* player =  Unit::GetPlayer(*me,EventStarter))
            {
                player->AreaExploredOrEventHappens(QUEST_INNCOENT_DISGUISE);
            }
            part_timer = 500;
            break;
        }
    }

    void EnterCombat(Unit *who) { }
    void UpdateAI(const uint32 diff)
    {
        if(EventStarted)
        {
            if(part_timer <= diff)
            {
                SayPart(part);
                part++;

                if( part > 6)
                {
                    Reset();
                    return;
                }
            }else part_timer -= diff;
        }

        if (!UpdateVictim() )
            return;

        DoMeleeAttackIfReady();
    }
};
};

/********************
Ice Stone
*********************/
#define GOSSIP_OPTION           "Place your hand on the Ice Stone"

#define ICE_STONE_QUEST_22      11917
#define ICE_STONE_SUMMON_22     26116
#define ZONE_ASHENVALE          331

#define ICE_STONE_QUEST_32      11947
#define ICE_STONE_SUMMON_32     26178
#define ZONE_DESOLACE           405

#define ICE_STONE_QUEST_43      11948
#define ICE_STONE_SUMMON_43     26204
#define ZONE_STRANGLETHORN      33

#define ICE_STONE_QUEST_51      11952
#define ICE_STONE_SUMMON_51     26214
#define ZONE_SEARING_GORGE      51

#define ICE_STONE_QUEST_60      11953
#define ICE_STONE_SUMMON_60     26215
#define ZONE_SILITHUS           1377

#define ICE_STONE_QUEST_67      11954
#define ICE_STONE_SUMMON_67     26216
#define ZONE_HELLFIRE           3483

class go_ice_stone : public GameObjectScript
{
public:
    go_ice_stone() : GameObjectScript("go_ice_stone") { }

    uint32 GetIceStoneSummonEntry(GameObject*_GO, Player *player)
    {
        if(player->GetQuestStatus(ICE_STONE_QUEST_22) == QUEST_STATUS_INCOMPLETE && _GO->GetZoneId() == ZONE_ASHENVALE)
            return ICE_STONE_SUMMON_22;

        if(player->GetQuestStatus(ICE_STONE_QUEST_32) == QUEST_STATUS_INCOMPLETE && _GO->GetZoneId() == ZONE_DESOLACE)
            return ICE_STONE_SUMMON_32;

        if(player->GetQuestStatus(ICE_STONE_QUEST_43) == QUEST_STATUS_INCOMPLETE && _GO->GetZoneId() == ZONE_STRANGLETHORN)
            return ICE_STONE_SUMMON_43;

        if(player->GetQuestStatus(ICE_STONE_QUEST_51) == QUEST_STATUS_INCOMPLETE && _GO->GetZoneId() == ZONE_SEARING_GORGE)
            return ICE_STONE_SUMMON_51;

        if(player->GetQuestStatus(ICE_STONE_QUEST_60) == QUEST_STATUS_INCOMPLETE && _GO->GetZoneId() == ZONE_SILITHUS)
            return ICE_STONE_SUMMON_60;

        if(player->GetQuestStatus(ICE_STONE_QUEST_67) == QUEST_STATUS_INCOMPLETE && _GO->GetZoneId() == ZONE_HELLFIRE)
            return ICE_STONE_SUMMON_67;

        return 0;
    }

    bool ShowIceStoneOption(GameObject*_GO, Player *player)
    {
        return go_ice_stone::GetIceStoneSummonEntry(_GO,player) > 0;
    }

    bool OnGossipHello(Player *player, GameObject* _GO)
    {
        if (go_ice_stone::ShowIceStoneOption(_GO,player))
        {
            player->ADD_GOSSIP_ITEM(0, GOSSIP_OPTION, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(_GO->GetGOInfo()->questgiver.gossipID, _GO->GetGUID());
        return true;
    }


    void SendActionMenu(Player *player, GameObject* _GO, uint32 action)
    {
        switch(action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                    uint32 entry = go_ice_stone::GetIceStoneSummonEntry(_GO,player);
                    if(entry > 0)
                    {
                        float x,y,z;
                        _GO->GetPosition(x,y,z);
                        Creature* temp = _GO->SummonCreature(entry,x,y,z,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,10000);
                        if(temp && player)
                            temp->AI()->AttackStart(player);
                    }
                break;
        }
    }

    bool OnGossipSelect(Player *player, GameObject* _GO, uint32 sender, uint32 action )
    {
        switch(sender)
        {
            case GOSSIP_SENDER_MAIN:
        	    go_ice_stone::SendActionMenu(player, _GO, action);
                player->CLOSE_GOSSIP_MENU();
                break;
        }
        return true;
    }
};

/********************
An Innocent Disguise
*********************/
float Wyrm_SomePositions[5][3] =
{
    {-3560.477f, 512.431f, 19.2f},      //Vagath ... Shadowlords
    {-3572.920f, 662.789f, -1.0f},      //Start Akama
    {-3572.825f, 621.806f,  6.3f},      //Stop Akama
    {-3561.880f, 598.995f,  9.3f},      //Stop Maiev
    {-3604.344f, 343.222f, 39.2f}       //EndPoint
};

enum XiriPhases
{
    PHASE_SUMMON_DEMONS,
    PHASE_SUMMON_AKAMA,
    PHASE_ATTACK,
    PHASE_KILL_WAIT,
    PHASE_END,
    PHASE_WAIT
};

#define ENTRY_VAGATH                    23152
#define ENTRY_ILLIDARI_SHADOWLORD       22988
#define ENTRY_AKAMA                     23191
#define ENTRY_MAIEV                     22989

class npc_xiri : public CreatureScript
{
public:
    npc_xiri() : CreatureScript("npc_xiri") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new npc_xiriAI (_Creature);
    }

struct npc_xiriAI : public ScriptedAI
{
    npc_xiriAI(Creature *c) : ScriptedAI(c)
    {
        EventStarted = false;
    }

    uint64 EventStarter;
    bool EventStarted;

    XiriPhases Phase;
    XiriPhases NextPhase;

    uint32 Wait_Timer;
    Creature* temp;

    uint64 Akama;
    uint64 Maiev;
    uint64 Vagath;
    uint64 Ashtongue[5];
    uint64 Demons[6];

    void Reset()
    {
        //EventStarter = 0;
        //EventStarted = false;
    }

    void MoveInLineOfSight(Unit *who){}

    void StartEvent(Player* starter)
    {
        EventStarted = true;
        EventStarter = starter->GetGUID();

        me->setActive(true);

        Phase = PHASE_WAIT;
        NextPhase = PHASE_SUMMON_DEMONS;
        Wait_Timer = 10000;

        me->SetUInt32Value(UNIT_NPC_FLAGS,0);
    }

    bool AreDemonsDead()
    {
        for(int i = 0; i < 6; i++)
        {
            Creature* c_Demon = Creature::GetCreature((*me),Demons[i]);
            if(c_Demon && c_Demon->isAlive())
                return false;
        }
        return true;
    }

    void ForceDespawn(Creature* c_creature)
    {
        c_creature->GetMotionMaster()->MoveIdle();
        c_creature->SetVisible(false);
        c_creature->DealDamage(c_creature,c_creature->GetHealth());
        c_creature->RemoveCorpse();

    }

    void EnterCombat(Unit *who) { }

    //not used in Trinityd, function for external script library
    void EventHappens(Player* player, uint32 questId)
    {
        if( Group *pGroup = player->GetGroup() )
        {
            for(GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player *pGroupGuy = itr->getSource();

                // for any leave or dead (with not released body) group member at appropriate distance
                if( pGroupGuy && pGroupGuy->IsWithinDistInMap(me,500) && !pGroupGuy->GetCorpse() )
                    pGroupGuy->AreaExploredOrEventHappens(questId);
            }
        }
        else
            player->AreaExploredOrEventHappens(questId);
    }


    void UpdateAI(const uint32 diff)
    {
        if(!EventStarted)
            return;
        {

            Creature* c_Vagath;
            Creature* c_Akama;
            Creature* c_Maiev;

            switch(Phase)
            {
            case PHASE_SUMMON_DEMONS:
                temp = me->SummonCreature(ENTRY_VAGATH,Wyrm_SomePositions[0][0],Wyrm_SomePositions[0][1],Wyrm_SomePositions[0][2],M_PI*0.5,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                Vagath = temp->GetGUID();

                temp = me->SummonCreature(ENTRY_ILLIDARI_SHADOWLORD,Wyrm_SomePositions[0][0]-17,Wyrm_SomePositions[0][1]+5,Wyrm_SomePositions[0][2]+1,M_PI*0.5 ,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                Demons[0] = temp->GetGUID();
                temp = me->SummonCreature(ENTRY_ILLIDARI_SHADOWLORD,Wyrm_SomePositions[0][0]-12,Wyrm_SomePositions[0][1]+5,Wyrm_SomePositions[0][2]+1,M_PI*0.5,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                Demons[1] = temp->GetGUID();
                temp = me->SummonCreature(ENTRY_ILLIDARI_SHADOWLORD,Wyrm_SomePositions[0][0]-7,Wyrm_SomePositions[0][1]+5,Wyrm_SomePositions[0][2]+1,M_PI*0.5,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                Demons[2] = temp->GetGUID();

                temp = me->SummonCreature(ENTRY_ILLIDARI_SHADOWLORD,Wyrm_SomePositions[0][0]+17,Wyrm_SomePositions[0][1]+5,Wyrm_SomePositions[0][2]+1,M_PI*0.5,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                Demons[3] = temp->GetGUID();
                temp = me->SummonCreature(ENTRY_ILLIDARI_SHADOWLORD,Wyrm_SomePositions[0][0]+12,Wyrm_SomePositions[0][1]+5,Wyrm_SomePositions[0][2]+1,M_PI*0.5,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                Demons[4] = temp->GetGUID();
                temp = me->SummonCreature(ENTRY_ILLIDARI_SHADOWLORD,Wyrm_SomePositions[0][0]+7,Wyrm_SomePositions[0][1]+5,Wyrm_SomePositions[0][2]+1,M_PI*0.5,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                Demons[5] = temp->GetGUID();

                Phase = PHASE_WAIT;
                NextPhase = PHASE_SUMMON_AKAMA;
                Wait_Timer = 5000;
                break;
            case PHASE_SUMMON_AKAMA:
                temp = me->SummonCreature(ENTRY_AKAMA,Wyrm_SomePositions[1][0],Wyrm_SomePositions[1][1],Wyrm_SomePositions[1][2],M_PI*1.5f,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                temp->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                temp->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[2][0],Wyrm_SomePositions[2][1],Wyrm_SomePositions[2][2]);
                Akama = temp->GetGUID();

                temp = me->SummonCreature(ENTRY_MAIEV,Wyrm_SomePositions[1][0],Wyrm_SomePositions[1][1],Wyrm_SomePositions[1][2],M_PI*1.5f,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                temp->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                //temp->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, 44850);
                //temp->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + 1, 0);
                //temp->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + 2, 45738);
                SetEquipmentSlots(false, 44850, EQUIP_UNEQUIP, EQUIP_NO_CHANGE);
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 2, 45738);
                temp->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[3][0],Wyrm_SomePositions[3][1],Wyrm_SomePositions[3][2]);
                Maiev = temp->GetGUID();

                temp = me->SummonCreature(21701,Wyrm_SomePositions[1][0],Wyrm_SomePositions[1][1],Wyrm_SomePositions[1][2],M_PI*1.5f,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                temp->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                temp->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[3][0],Wyrm_SomePositions[3][1]+5,Wyrm_SomePositions[3][2]);
                Ashtongue[0] = temp->GetGUID();

                temp = me->SummonCreature(21701,Wyrm_SomePositions[1][0],Wyrm_SomePositions[1][1],Wyrm_SomePositions[1][2],M_PI*1.5f,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                temp->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                temp->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[3][0]+5,Wyrm_SomePositions[3][1]+10,Wyrm_SomePositions[3][2]);
                Ashtongue[1] = temp->GetGUID();

                temp = me->SummonCreature(21701,Wyrm_SomePositions[1][0],Wyrm_SomePositions[1][1],Wyrm_SomePositions[1][2],M_PI*1.5f,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                temp->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                temp->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[3][0]-5,Wyrm_SomePositions[3][1]+10,Wyrm_SomePositions[3][2]);
                Ashtongue[2] = temp->GetGUID();

                temp = me->SummonCreature(21701,Wyrm_SomePositions[1][0],Wyrm_SomePositions[1][1],Wyrm_SomePositions[1][2],M_PI*1.5f,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                temp->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                temp->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[3][0]+10,Wyrm_SomePositions[3][1]+15,Wyrm_SomePositions[3][2]);
                Ashtongue[3] = temp->GetGUID();

                temp = me->SummonCreature(21701,Wyrm_SomePositions[1][0],Wyrm_SomePositions[1][1],Wyrm_SomePositions[1][2],M_PI*1.5f,TEMPSUMMON_TIMED_DESPAWN,300000);
                temp->setActive(true);
                temp->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                temp->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[3][0]-10,Wyrm_SomePositions[3][1]+15,Wyrm_SomePositions[3][2]);
                Ashtongue[4] = temp->GetGUID();

                Phase = PHASE_WAIT;
                NextPhase = PHASE_ATTACK;
                Wait_Timer = 20000;
                break;
            case PHASE_ATTACK:
                
                c_Vagath = Creature::GetCreature((*me),Vagath);
                c_Akama = Creature::GetCreature((*me),Akama);
                c_Maiev = Creature::GetCreature((*me),Maiev);
                if(c_Vagath && c_Akama && c_Maiev)
                {
                    c_Akama->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[0][0],Wyrm_SomePositions[0][1]+10,Wyrm_SomePositions[0][2]);
                    c_Akama->SetHomePosition(Wyrm_SomePositions[0][0],Wyrm_SomePositions[0][1]+10,Wyrm_SomePositions[0][2],M_PI*1.5f);
                    c_Maiev->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[0][0],Wyrm_SomePositions[0][1],Wyrm_SomePositions[0][2]);
                    c_Maiev->SetHomePosition(Wyrm_SomePositions[0][0],Wyrm_SomePositions[0][1],Wyrm_SomePositions[0][2],M_PI*1.5f);
                
                    for(int i = 0; i < 5; i++)
                    {
                        Creature* c_Ashtongue;
                        c_Ashtongue = Creature::GetCreature((*me),Ashtongue[i]);
                        if(c_Ashtongue)
                        {
                            c_Ashtongue->GetMotionMaster()->MovePoint(0,float(Wyrm_SomePositions[0][0]+(rand()%5-2)),float(Wyrm_SomePositions[0][1]+10),float(Wyrm_SomePositions[0][2]+0.5));
                            c_Ashtongue->SetHomePosition(float(Wyrm_SomePositions[0][0]+(rand()%5-2)),float(Wyrm_SomePositions[0][1]+10),float(Wyrm_SomePositions[0][2]+0.5),M_PI*1.5f);
                        }
                    }

                }
                Phase = PHASE_KILL_WAIT;
                break;
            case PHASE_KILL_WAIT:
                c_Vagath = Creature::GetCreature((*me),Vagath);
                if((!c_Vagath || c_Vagath->isDead()) && AreDemonsDead())
                {
                    for(int i = 0; i < 5; i++)
                    {
                        Creature* c_Ashtongue;
                        c_Ashtongue = Creature::GetCreature((*me),Ashtongue[i]);
                        if(c_Ashtongue)
                        {
                            c_Ashtongue->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            c_Ashtongue->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[4][0],Wyrm_SomePositions[4][1],Wyrm_SomePositions[4][2]);
                            c_Ashtongue->SetHomePosition(Wyrm_SomePositions[4][0],Wyrm_SomePositions[4][1],Wyrm_SomePositions[4][2],M_PI*1.5f);
                        }
                    }

                    c_Akama = Creature::GetCreature((*me),Akama);
                    c_Maiev = Creature::GetCreature((*me),Maiev);
                    if(c_Akama)
                    {
                        c_Akama->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        c_Akama->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[4][0],Wyrm_SomePositions[4][1],Wyrm_SomePositions[4][2]);
                        c_Akama->SetHomePosition(Wyrm_SomePositions[4][0],Wyrm_SomePositions[4][1],Wyrm_SomePositions[4][2],M_PI*1.5f);

                    }
                    if(c_Maiev)
                    {
                        c_Maiev->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        c_Maiev->GetMotionMaster()->MovePoint(0,Wyrm_SomePositions[4][0],Wyrm_SomePositions[4][1],Wyrm_SomePositions[4][2]);
                        c_Maiev->SetHomePosition(Wyrm_SomePositions[4][0],Wyrm_SomePositions[4][1],Wyrm_SomePositions[4][2],M_PI*1.5f);
                    }

                    Phase = PHASE_WAIT;
                    NextPhase = PHASE_END;
                    Wait_Timer = 15000;
                }
                break;
            case PHASE_END:
                c_Akama = Creature::GetCreature((*me),Akama);
                c_Maiev = Creature::GetCreature((*me),Maiev);

                if(c_Akama) ForceDespawn(c_Akama);
                if(c_Maiev) ForceDespawn(c_Maiev);
                for(int i = 0; i < 5; i++)
                {
                    Creature* c_Ashtongue;
                    c_Ashtongue = Creature::GetCreature((*me),Ashtongue[i]);
                    if(c_Ashtongue) ForceDespawn(c_Ashtongue);
                }

                if(Player* starter = Unit::GetPlayer(*me,EventStarter))
                {
                    EventHappens(starter, 10985);
                    EventHappens(starter, 13429);
                }

                me->SetUInt32Value(UNIT_NPC_FLAGS,3);
                EventStarted = false;
                break;
            case PHASE_WAIT:
                if(Wait_Timer <= diff)
                {
                    Phase = NextPhase;
                    Wait_Timer = 0;
                }else Wait_Timer -= diff;
                break;
            }

        }
    }
};

#define XIRI_OPTION      "Ich bin bereit."

    bool OnGossipHello(Player *player, Creature *_Creature)
    {
        if (_Creature->isQuestGiver())
            player->PrepareQuestMenu( _Creature->GetGUID() );

        if ( (player->GetQuestStatus(10985) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(13429) == QUEST_STATUS_INCOMPLETE ))
            player->ADD_GOSSIP_ITEM( 0, XIRI_OPTION, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(_Creature),_Creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action)
    {
            if(action == GOSSIP_ACTION_INFO_DEF+1)
            {
                player->CLOSE_GOSSIP_MENU();
                CAST_AI(npc_xiri::npc_xiriAI,_Creature->AI())->StartEvent(player);
            }

        return true;
    }
};

#define SPELL_SHADOW_STRIKE                 40685
#define SPELL_THROW_DAGGERS                 41152

class npc_preeven_maiev : public CreatureScript
{
public:
    npc_preeven_maiev() : CreatureScript("npc_preeven_maiev") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new npc_preeven_maievAI (_Creature);
    }

    struct npc_preeven_maievAI : public ScriptedAI
    {
        npc_preeven_maievAI(Creature *c) : ScriptedAI(c)
        {
            Reset();
        }

        uint32 strike_Timer;
        uint32 throw_Timer;

        // void DamageTaken(Unit *done_by, uint32 &damage)
        //{
        //    damage = 0;
        //}

        void Reset()
        {
                strike_Timer = 10000 + rand()%10000;
                throw_Timer = 10000 + rand()%10000;
        }

        void EnterCombat(Unit *who) { }
        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim() )
                return;

            if(strike_Timer <= diff)
            {
                Unit *ptarget = SelectTarget(SELECT_TARGET_RANDOM,0);
                DoCast(ptarget,SPELL_SHADOW_STRIKE);
                strike_Timer = 10000 + rand()%10000;
            }else strike_Timer -= diff;

        
            if(throw_Timer <= diff)
            {
                DoCast(me->getVictim(),SPELL_THROW_DAGGERS);
                throw_Timer = 10000 + rand()%10000;
            }else throw_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/********************
Event: LoL Scourge Invasion
*********************/


//Script-Basement for 3.X Ghouls

class npc_ghoul : public CreatureScript
{
public:
    npc_ghoul() : CreatureScript("npc_ghoul") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new npc_ghoulAI (_Creature);
    }

    struct npc_ghoulAI : public ScriptedAI
    {
        npc_ghoulAI(Creature *c) : ScriptedAI(c) { burrowed = false; }

        bool burrowed;
        bool inburrowing;

        uint32 burrow_Timer;

        void SetBurrowed(bool value)
        {
            burrowed = value;
            if(burrowed)
            {
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_SUBMERGED_NEW);
            }
            else
            {
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            }

            //EMOTE_STATE_SUBMERGED_NEW
            //EMOTE_STATE_SUBMERGED
        }

        void Submerge()
        {
            inburrowing = true;
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_SUBMERGE);
            burrow_Timer = 2000;
        }

        void Birth()
        {
            inburrowing = true;
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_EMERGE);
            burrow_Timer = 4000;
        }

        void AttackStart(Unit *who)
        {
            if(!burrowed)
                ScriptedAI::AttackStart(who);
        }

        void MoveInLineOfSight(Unit *who)
        {
            if(!burrowed)
                ScriptedAI::MoveInLineOfSight(who);
        }

        void Reset()
        {
            burrow_Timer = 0;
            inburrowing = false;
        }

        void EnterCombat(Unit *who) { }
        void UpdateAI(const uint32 diff)
        {
            if(inburrowing)
            {
                if(burrow_Timer <= diff)
                {
                    SetBurrowed(!burrowed);
                    burrow_Timer = 10000;
                    inburrowing = false;
                }else burrow_Timer -= diff;
                return;
            }

            if(burrowed)
            {
                if(burrow_Timer <= diff)
                {
                    Birth();
                }else burrow_Timer -= diff;
                return;
            }else
            {
                if(burrow_Timer <= diff)
                {
                    Submerge();
                }else burrow_Timer -= diff;
                return;
            }

            if (!UpdateVictim() )
                return;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_lol_event()
{
    new npc_midsummer_scorchling();
    new npc_ice_caller_briatha();
    new go_ice_stone();
    new npc_xiri();
    new npc_preeven_maiev();
    new npc_ghoul();

    /*
    update creature_Template set scriptname = 'npc_xiri' where entry = 18528
    UPDATE `creature_template` SET `modelid_A` = 21349  , `modelid_H` = 21349  , `minlevel` = 73  , `maxlevel` = 73  , `minhealth` = 500000  , `maxhealth` = 500000  , `mindmg` = 3000  , `maxdmg` = 4000  , `attackpower` = 16125  , `baseattacktime` = 2000  , `faction_A` = 1866  , `faction_H` = 1866 , `armor` = 6000 , `equipment_id` = 2182 , scriptname = 'npc_preeven_maiev' WHERE `entry` = 22989;
    UPDATE `creature_template` SET `attackpower` = 6540  , `speed` = 1.1 , `type_flags` WHERE `entry` = 23191;
    UPDATE `creature_template` SET `minlevel` = 72  , `maxlevel` = 72  , `minhealth` = 147600  , `maxhealth` = 147600  , `mindmg` = 3003  , `maxdmg` = 6139  , `attackpower` = 31997  , `baseattacktime` = 1400  , `rangeattacktime` = 1900  , `rangedattackpower` = 100  , `rank` = 3  , `faction_A` = 14  , `faction_H` = 14  , `type_flags` = 0  , `armor` = 7387  , `speed` = 1.48  , `mechanic_immune_mask` = 617299803 WHERE `entry` = 23152;
    */
}
