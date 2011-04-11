#include "ScriptPCH.h"
#include "arcatraz.h"

//Dalliah the Doomsayer
//Spells
#define SPELL_WHIRLWIND         36142
#define SPELL_HEAL              36144
#define H_SPELL_HEAL            39013
#define SPELL_GIFT_DOOMSAYER    36173
#define H_SPELL_GIFT_DOOMSAYER  39009

#define H_SPELL_SHADOW_WAVE     39016

#define SOUND_INTRO             11236
#define SAY_D_AGGRO             "It is unwise to anger me."
#define SOUND_D_AGGRO           11086
#define SAY_D_HEAL_1            "Ahh... That is much better." 
#define SOUND_D_HEAL_1          11091
#define SAY_D_HEAL_2            "Ahh... Just what I needed."
#define SOUND_D_HEAL_2          11092
#define SAY_D_KILL_1            "Completely ineffective. Just like someone else I know." 
#define SOUND_D_KILL_1          11087
#define SAY_D_KILL_2            "You chose the wrong opponent."
#define SOUND_D_KILL_2          11088    
#define SAY_D_WHIRL_1           "I'll cut you to pieces!" 
#define SOUND_D_WHIRL_1         11089
#define SAY_D_WHIRL_2           "Reap the Whirlwind!"
#define SOUND_D_WHIRL_2         11090
#define SAY_D_DEATH             "Now I'm really... angry..." 
#define SOUND_D_DEATH           11093

#define SAY_AGGRO_SOCCO         "Don't worry about me; kill that worthless dullard instead!"
#define SOUND_AGGRO_SOCCO       11085
#define SAY_25_SOCCO            "More than you can handle, scryer?"
#define SOUND_25_SOCCO          11094
#define SAY_DEATH_SOCCO         "Congratulations. I've wanted to do that for years." 
#define SOUND_DEATH_SOCCO       11097

class boss_dalliah : public CreatureScript
{
public:
    boss_dalliah() : CreatureScript("boss_dalliah") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new boss_dalliahAI (_Creature);
    }

    struct boss_dalliahAI : public ScriptedAI
    {
        boss_dalliahAI(Creature *c) : ScriptedAI(c) 
        {
            HeroicMode = me->GetMap()->IsHeroic();
            pInstance = c->GetInstanceScript();
            once = false;
            otherdead = false;
        }
        InstanceScript *pInstance;
        bool HeroicMode;

        bool InCombat;

        uint32 whirlwind_timer;
        uint32 heal_timer;
        uint32 gift_timer;
        uint32 shadow_wave_timer;

        bool hp25;
        bool otherhp25;
        bool otheraggro;
        bool otherdead;
        bool once;
        bool isHealing;

        void Reset() 
        {
            whirlwind_timer = 15000;
            heal_timer = 999999;
            gift_timer = 10000;
            shadow_wave_timer = 12500;

            InCombat = false;
            hp25 = false;
            otherhp25 = false;
            otheraggro = false;
            isHealing = false;
            if (pInstance)
                pInstance->SetData(DATA_DALLIAHTHEDOOMSAYEREVENT, NOT_STARTED);
        }

        void EnterCombat(Unit *who)
        {
            if (pInstance)
                pInstance->SetData(DATA_DALLIAHTHEDOOMSAYEREVENT, IN_PROGRESS);
            DoPlaySoundToSet(me,SOUND_D_AGGRO);
            me->MonsterYell(SAY_D_AGGRO,LANG_UNIVERSAL,NULL);
        }


        void SpellHit(Unit *caster, const SpellEntry*spellentry)
        {
            switch(spellentry->Id)
            {
                case SPELL_HEAL:
                case H_SPELL_HEAL:
                    switch(rand()%2)
                    {
                    case 0:
                        DoPlaySoundToSet(me,SOUND_D_HEAL_1);
                        me->MonsterYell(SAY_D_HEAL_1,LANG_UNIVERSAL,NULL);
                        break;
                    case 1:
                        DoPlaySoundToSet(me,SOUND_D_HEAL_2);
                        me->MonsterYell(SAY_D_HEAL_2,LANG_UNIVERSAL,NULL);
                    break;
                    }
                    isHealing = false;
                break;
            }

            if ((spellentry->Effect[0]!=SPELL_EFFECT_INTERRUPT_CAST && spellentry->Effect[1]!=SPELL_EFFECT_INTERRUPT_CAST && spellentry->Effect[2]!=SPELL_EFFECT_INTERRUPT_CAST) || !me->IsNonMeleeSpellCasted(false))
                return;

            if(isHealing)
            {
                me->InterruptNonMeleeSpells(false);
                isHealing = false;
            }
        }

        void KilledUnit(Unit *victim)
        {
            switch(rand()%2)
                {
            case 0:
                DoPlaySoundToSet(me, SOUND_D_KILL_1);
                me->MonsterYell(SAY_D_KILL_1,LANG_UNIVERSAL,NULL);
                break;
            case 1:
                DoPlaySoundToSet(me, SOUND_D_KILL_2);
                me->MonsterYell(SAY_D_KILL_2,LANG_UNIVERSAL,NULL);
                break;
            }
        }
 
        void JustDied(Unit* Killer)
        {
            DoPlaySoundToSet(me,SOUND_D_DEATH);
            me->MonsterYell(SAY_D_DEATH ,LANG_UNIVERSAL,NULL);
            if (pInstance)
                pInstance->SetData(DATA_DALLIAHTHEDOOMSAYEREVENT, DONE);
        }

        void MoveInLineOfSight(Unit *who)
        {
             if (!once && me->IsWithinLOSInMap(who)&& me->IsWithinDistInMap(who, 50) )
            {
                DoPlaySoundToSet(me,SOUND_INTRO);
                once = true;
            }else
            {
                ScriptedAI::MoveInLineOfSight(who);
            }
        }
   
        void UpdateAI(const uint32 diff)
        {
            if (!otherdead && pInstance)
            {
                Unit* Temp = NULL; 
                Temp = Unit::GetUnit((*me),pInstance->GetData64(DATA_WRATH_SCRYERSOCCOTHRATES));
            
                if (Temp->isDead())
                {
                    DoPlaySoundToSet(me, SOUND_DEATH_SOCCO);
                    me->MonsterYell(SAY_DEATH_SOCCO,LANG_UNIVERSAL,NULL);
                    otherdead = true;
                }

                if (!otheraggro)
                {
                     if(pInstance->GetData(DATA_WRATH_SCRYERSOCCOTHRATESEVENT) == IN_PROGRESS)
                     {
                        DoPlaySoundToSet(me,SOUND_AGGRO_SOCCO );
                        me->MonsterYell(SAY_AGGRO_SOCCO ,LANG_UNIVERSAL,NULL);
                        otheraggro = true;
                     }
                }

                if (!otherhp25)
                {
                    if(pInstance->GetData(DATA_SOCCOTHRATES25) == 1 ) 
                    {
                        DoPlaySoundToSet(me,SOUND_25_SOCCO );
                        me->MonsterYell(SAY_25_SOCCO ,LANG_UNIVERSAL,NULL);
                        otherhp25 = true;
                    }
                }
            }

            if (!UpdateVictim())
                return;

            if(whirlwind_timer < diff)
            {
                switch (rand()%2)
                {
                case 0:
                    DoPlaySoundToSet(me,SOUND_D_WHIRL_1 );
                    me->MonsterYell(SAY_D_WHIRL_1 ,LANG_UNIVERSAL,NULL);
                    break;
                case 1:
                    DoPlaySoundToSet(me,SOUND_D_WHIRL_2);
                    me->MonsterYell(SAY_D_WHIRL_2 ,LANG_UNIVERSAL,NULL);
                    break;
                }
                DoCast(me,SPELL_WHIRLWIND);
                whirlwind_timer = 35000;
                heal_timer = 6000;
            }else whirlwind_timer -= diff;

            if(heal_timer < diff)
            {
                if (!me->IsNonMeleeSpellCasted(false))
                {
                    isHealing = true;
                    DoCast(me,HeroicMode ? H_SPELL_HEAL : SPELL_HEAL);
                    heal_timer = 900000;
                }
            }else heal_timer -= diff;

            if( gift_timer < diff)
            {
                DoCast(me->getVictim(),HeroicMode ? H_SPELL_GIFT_DOOMSAYER : SPELL_GIFT_DOOMSAYER);
                gift_timer = 30000;
            }else gift_timer -= diff;

            if (!hp25)
            {
                if(pInstance && (me->GetHealth()*100) / me->GetMaxHealth() < 25) 
                {
                    hp25 = true;
                    pInstance->SetData(DATA_DALLIAH25,1);
                }
            }

            if(HeroicMode)
            {
                if(shadow_wave_timer < diff)
                {
                    if (!me->IsNonMeleeSpellCasted(false))
                    {
                        Unit *ptarget = SelectTarget(SELECT_TARGET_RANDOM,0);
                        DoCast(ptarget,H_SPELL_SHADOW_WAVE);
                        shadow_wave_timer = 10000;
                    }
                }else shadow_wave_timer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

//Wrath-Scryer Soccothrates
//Spells
#define SPELL_FEL_IMMOLATION    36051
#define H_SPELL_FEL_IMMOLATION  39007
#define SPELL_FELFIRE           35769
#define SPELL_KNOCK_BACK        36512
#define SPELL_LINEUP            35770
#define SPELL_FELFIRE_SHOCK     35759
#define H_SPELL_FELFIRE_SHOCK   39006


#define SAY_S_AGGRO             "At last, a target for my frustrations!" 
#define SOUND_S_AGGRO           11238
#define SAY_S_CHARGE_1          "On guard!"
#define SOUND_S_CHARGE_1        11241
#define SAY_S_CHARGE_2          "Defend yourself, for all the good it will do..."
#define SOUND_S_CHARGE_2        11242
#define SAY_S_KILL_1            "Yes, that was quite satisfying."
#define SOUND_S_KILL_1          11239
#define SAY_S_KILL_2            "Much better."
#define SOUND_S_KILL_2          11240
#define SAY_S_DEATH             "Knew this was... the only way out." 
#define SOUND_S_DEATH           11243

#define SAY_AGGRO_DALLI         "Have you come to kill Dalliah? Can I watch?"
#define SOUND_AGGRO_DALLI       11237
#define SAY_25_DALLI_1          "Having problems, Dalliah? How nice."
#define SOUND_25_DALLI_1        11244
#define SAY_25_DALLI_2          "I suggest a new strategy, you draw the attackers while I gather reinforcements. Hahaha!"
#define SOUND_25_DALLI_2        11246
#define SAY_DEATH_DALLI         "Finally! Well done!" 
#define SOUND_DEATH_DALLI       11247

class boss_soccothates : public CreatureScript
{
public:
    boss_soccothates() : CreatureScript("boss_soccothates") { }

    CreatureAI* GetAI(Creature *_Creature) const
    {
        return new boss_soccothatesAI (_Creature);
    }

    struct boss_soccothatesAI : public ScriptedAI
    {
        boss_soccothatesAI(Creature *c) : ScriptedAI(c) 
        {
            HeroicMode = me->GetMap()->IsHeroic();
            pInstance = c->GetInstanceScript();
            Reset();
            otherdead = false;
        }
        InstanceScript *pInstance;
        bool HeroicMode;

        bool InCombat;
        bool hp25;
        bool otherhp25;
        bool otheraggro;
        bool otherdead;

        uint32 flameshock_timer;
        uint32 flame_timer;
        uint32 lineup_timer;

        void Reset() 
        {
            flameshock_timer = 15000;
            flame_timer = 10000;
            lineup_timer = 0;

            InCombat = false;
            hp25 = false;
            otherhp25 = false;
            otheraggro = false;

            if (pInstance)
                pInstance->SetData(DATA_WRATH_SCRYERSOCCOTHRATESEVENT, NOT_STARTED);
        }

        void EnterCombat(Unit *who)
        {
            me->RemoveAllAuras();
            DoCast(me,HeroicMode ? H_SPELL_FEL_IMMOLATION : SPELL_FEL_IMMOLATION);

            if (pInstance)
                pInstance->SetData(DATA_WRATH_SCRYERSOCCOTHRATESEVENT, IN_PROGRESS);

            DoPlaySoundToSet(me,SOUND_S_AGGRO);
            me->MonsterYell(SAY_S_AGGRO,LANG_UNIVERSAL,NULL);
        }

        void KilledUnit(Unit *victim)
        {    
            switch(rand()%2)
            {
            case 0:
                DoPlaySoundToSet(me, SOUND_S_KILL_1);
                me->MonsterYell(SAY_S_KILL_1,LANG_UNIVERSAL,NULL);
                break;
            case 1:
                DoPlaySoundToSet(me, SOUND_S_KILL_2);
                me->MonsterYell(SAY_S_KILL_2,LANG_UNIVERSAL,NULL);
                break;
            }
        }
 
        void JustDied(Unit* Killer)
        {
            DoPlaySoundToSet(me,SOUND_S_DEATH);
            me->MonsterYell(SAY_S_DEATH ,LANG_UNIVERSAL,NULL);
            if (pInstance)
                pInstance->SetData(DATA_WRATH_SCRYERSOCCOTHRATESEVENT, DONE);
        }
   
        void UpdateAI(const uint32 diff)
        {
            if (!otherdead && pInstance)
            {
                Unit* Temp = NULL; 
                Temp = Unit::GetUnit((*me),pInstance->GetData64(DATA_DALLIAHTHEDOOMSAYER));
            
                if (Temp->isDead())
                {
                    DoPlaySoundToSet(me, SOUND_DEATH_DALLI);
                    me->MonsterYell(SAY_DEATH_DALLI,LANG_UNIVERSAL,NULL);
                    otherdead = true;
                }


                if (!otheraggro)
                {
                     if(pInstance->GetData(DATA_DALLIAHTHEDOOMSAYEREVENT) == IN_PROGRESS)
                     {
                        DoPlaySoundToSet(me,SOUND_AGGRO_DALLI );
                        me->MonsterYell(SAY_AGGRO_DALLI ,LANG_UNIVERSAL,NULL);
                        otheraggro = true;
                     }
                }

                if (!otherhp25)
                {
                    if(pInstance->GetData(DATA_DALLIAH25) == 1 ) 
                    {
                        switch(rand()%2)
                        {
                        case 0:
                            DoPlaySoundToSet(me,SOUND_25_DALLI_1 );
                            me->MonsterYell(SAY_25_DALLI_1 ,LANG_UNIVERSAL,NULL);
                            break;
                        case 1:
                            DoPlaySoundToSet(me,SOUND_25_DALLI_2 );
                            me->MonsterYell(SAY_25_DALLI_2 ,LANG_UNIVERSAL,NULL);
                            break;
                        }                
                        otherhp25 = true;
                    }
                }

            }

            if (!UpdateVictim())
                return;

            if ( flameshock_timer < diff)
            {
                Unit* ptarget = SelectTarget(SELECT_TARGET_RANDOM,0);
                if (ptarget)
                    DoCast(ptarget,HeroicMode ? H_SPELL_FELFIRE_SHOCK : SPELL_FELFIRE_SHOCK);
                flameshock_timer = 15000; 
            }else flameshock_timer -= diff;

            if (flame_timer < diff)
            {
                switch (rand()%2)
                {
                    case 0:
                        DoPlaySoundToSet(me,SOUND_S_CHARGE_1);
                        me->MonsterYell(SAY_S_CHARGE_1 ,LANG_UNIVERSAL,NULL);
                        break;
                    case 1:
                        DoPlaySoundToSet(me,SOUND_S_CHARGE_2);
                        me->MonsterYell(SAY_S_CHARGE_2 ,LANG_UNIVERSAL,NULL);
                        break;
                }

                DoCast(me,SPELL_KNOCK_BACK);

                lineup_timer = 5000;
                flame_timer = 30000;
            }else flame_timer -= diff;

            if(lineup_timer)
            {
                if(lineup_timer < diff)
                {
                    if(!me->IsWithinMeleeRange(me->getVictim()))
                    {
                        DoCast(me,SPELL_FELFIRE,true);
                        lineup_timer = 200;
                    }else lineup_timer = 0;
                }else lineup_timer -= diff;
            }

            if (!hp25)
            {
                if(pInstance && (me->GetHealth()*100) / me->GetMaxHealth() < 25) 
                {
                    hp25 = true;
                    pInstance->SetData(DATA_SOCCOTHRATES25,1);
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_dalliah_soccothrates()
{
    new boss_dalliah();
    new boss_soccothates();
}

/*
update creature_template set scriptname = 'boss_dalliah' where entry = 20885;
update creature_template set scriptname = 'boss_soccothates' where entry = 20886;
*/