/*
 * Copyright 2021 ShadowCore
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

#include "ScriptMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "SpellScript.h"
#include "SpellAuras.h"
#include "ScriptedGossip.h"
#include "MotionMaster.h"
#include "GameObject.h"
#include "Transport.h"
#include "DarkmoonIsland.h"
#include "AchievementMgr.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "ScriptedCreature.h"
#include "DarkmoonIsland.h"
#include "Player.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "InstanceScript.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedEscortAI.h"
#include "WorldSession.h"
#include "Item.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "GameEventMgr.h"
#include "AchievementPackets.h"
#include "DB2HotfixGenerator.h"
#include "DB2Stores.h"
#include "CellImpl.h"
#include "ChatTextBuilder.h"
#include "Containers.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Language.h"
#include "Mail.h"
#include "ObjectMgr.h"
#include "RBAC.h"
#include "StringConvert.h"
#include "World.h"
#include "AreaTrigger.h"
#include "AreaTriggerAI.h"
#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "SpellScript.h"
#include "SpellAuras.h"
#include "SharedDefines.h"
#include "ObjectAccessor.h"
#include "TemporarySummon.h"
#include <sstream>

enum Enums
{
    //Spells
    SPELL_HUGE_SHARP_TEETH = 114078,
    SPELL_INTERDIMENSIONAL_HOP = 135056,

    //Events

};

// 58336 - Darkmoon Rabbit
class npc_darkmoon_rabbit_ird : public CreatureScript
{
public:
    npc_darkmoon_rabbit_ird() : CreatureScript("npc_darkmoon_rabbit_ird") { }

    struct npc_darkmoon_rabbit_irdAI : public ScriptedAI
    {
        npc_darkmoon_rabbit_irdAI(Creature* creature) : ScriptedAI(creature) { }

        void JustEngagedWith(Unit* who) override
        {
            me->CastSpell(who, SPELL_HUGE_SHARP_TEETH);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            events.Reset();
            _EnterEvadeMode();
            me->GetMotionMaster()->MoveTargetedHome();
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (!UpdateVictim())
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    default:
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        EventMap events;
    };

    CreatureAI* GetAI(Creature* p_Creature) const override
    {
        return new npc_darkmoon_rabbit_irdAI(p_Creature);
    }
};

void AddSC_darkmoon_rabbit()
{
    new npc_darkmoon_rabbit_ird();
}
