/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "BattlefieldTB.h"
#include "DB2Stores.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptSystem.h"
#include "SpellScript.h"
#include "WorldSession.h"

enum TBSpiritGuide
{
    SPELL_CHANNEL_SPIRIT_HEAL = 22011,

    GOSSIP_OPTION_ID_SLAGWORKS = 0,
    GOSSIP_OPTION_ID_IRONCLAD_GARRISON = 1,
    GOSSIP_OPTION_ID_WARDENS_VIGIL = 2,
    GOSSIP_OPTION_ID_EAST_SPIRE = 3,
    GOSSIP_OPTION_ID_WEST_SPIRE = 4,
    GOSSIP_OPTION_ID_SOUTH_SPIRE = 5,
};

class npc_tb_spirit_guide : public CreatureScript
{
    public:
        npc_tb_spirit_guide() : CreatureScript("npc_tb_spirit_guide") { }

        struct npc_tb_spirit_guideAI : public ScriptedAI
        {
            npc_tb_spirit_guideAI(Creature* creature) : ScriptedAI(creature) { }

            void UpdateAI(uint32 /*diff*/) override
            {
                if (!me->HasUnitState(UNIT_STATE_CASTING))
                    DoCast(me, SPELL_CHANNEL_SPIRIT_HEAL);
            }

            void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
            {
                player->PlayerTalkClass->SendCloseGossip();

                uint32 areaId = 0;
                switch (gossipListId)
                {
                    case GOSSIP_OPTION_ID_SLAGWORKS:
                        areaId = TB_GY_SLAGWORKS;
                        break;
                    case GOSSIP_OPTION_ID_IRONCLAD_GARRISON:
                        areaId = TB_GY_IRONCLAD_GARRISON;
                        break;
                    case GOSSIP_OPTION_ID_WARDENS_VIGIL:
                        areaId = TB_GY_WARDENS_VIGIL;
                        break;
                    case GOSSIP_OPTION_ID_EAST_SPIRE:
                        areaId = TB_GY_EAST_SPIRE;
                        break;
                    case GOSSIP_OPTION_ID_WEST_SPIRE:
                        areaId = TB_GY_WEST_SPIRE;
                        break;
                    case GOSSIP_OPTION_ID_SOUTH_SPIRE:
                        areaId = TB_GY_SOUTH_SPIRE;
                        break;
                    default:
                        return;
                }

                if (WorldSafeLocsEntry const* safeLoc = sWorldSafeLocsStore.LookupEntry(areaId))
                    player->TeleportTo(safeLoc->MapID, safeLoc->Loc.X, safeLoc->Loc.Y, safeLoc->Loc.Z, 0);
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_tb_spirit_guideAI(creature);
        }
};

// 85123 - Siege Cannon - selects random target
class spell_siege_cannon : public SpellScriptLoader
{
public:
    spell_siege_cannon() : SpellScriptLoader("spell_siege_cannon") { }

    class spell_siege_cannon_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_siege_cannon_SpellScript);

        void SelectRandomTarget(std::list<WorldObject*>& targets)
        {
            if (targets.empty())
                return;

            WorldObject* target = Server::Containers::SelectRandomContainerElement(targets);
            targets.clear();
            targets.push_back(target);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_siege_cannon_SpellScript::SelectRandomTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_siege_cannon_SpellScript();
    }
};

void AddSC_tol_barad()
{
    new npc_tb_spirit_guide();
    new spell_siege_cannon();
}
