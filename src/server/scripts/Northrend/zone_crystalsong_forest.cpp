/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/* Script Data Start
SDName: CrystalSongForest
SDAuthor: Malcrom
SD%Complete: 99%
SDComment:
SDCategory: CrystalsongForest
Script Data End */

#include "ScriptMgr.h"
#include "ObjectAccessor.h"
#include "ScriptedCreature.h"

/*******************************************************
 * npc_warmage_violetstand
 *******************************************************/

enum Spells
{
    SPELL_TRANSITUS_SHIELD_BEAM = 48310
};

enum NPCs
{
    NPC_TRANSITUS_SHIELD_DUMMY   = 27306,
    NPC_WARMAGE_SARINA           = 32369,
    NPC_WARMAGE_HALISTER         = 32371,
    NPC_WARMAGE_ILSUDRIA         = 32372
};

class npc_warmage_violetstand : public CreatureScript
{
public:
    npc_warmage_violetstand() : CreatureScript("npc_warmage_violetstand") { }

    struct npc_warmage_violetstandAI : public ScriptedAI
    {
        npc_warmage_violetstandAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);
        }

        ObjectGuid targetGUID;

        void Reset() override
        {
            targetGUID.Clear();
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (me->IsNonMeleeSpellCast(false))
                return;

            if (!targetGUID)
            {
                if (me->GetEntry() == NPC_WARMAGE_SARINA)
                {
                    std::list<Creature*> orbList;
                    GetCreatureListWithEntryInGrid(orbList, me, NPC_TRANSITUS_SHIELD_DUMMY, 32.0f);
                    if (!orbList.empty())
                    {
                        for (Creature* orb : orbList)
                        {
                            if (orb->GetPositionY() < 1000)
                            {
                                targetGUID = orb->GetGUID();
                                break;
                            }
                        }
                    }
                }
                else if (Creature* pOrb = GetClosestCreatureWithEntry(me, NPC_TRANSITUS_SHIELD_DUMMY, 32.0f))
                    targetGUID = pOrb->GetGUID();
            }

            if (Creature* pOrb = ObjectAccessor::GetCreature(*me, targetGUID))
                DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_warmage_violetstandAI(creature);
    }
};

void AddSC_crystalsong_forest()
{
    new npc_warmage_violetstand();
}
