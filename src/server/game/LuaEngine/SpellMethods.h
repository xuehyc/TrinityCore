/*
* Copyright (C) 2010 - 2020 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef SPELLMETHODS_H
#define SPELLMETHODS_H

/***
 * An instance of a spell, created when the spell is cast by a [Unit].
 *
 * Inherits all methods from: none
 */
namespace LuaSpell
{
    /**
     * Returns `true` if the [Spell] is automatically repeating, `false` otherwise.
     *
     * @return bool isAutoRepeating
     */
    int IsAutoRepeat(lua_State* L, Spell* spell)
    {
        Eluna::Push(L, spell->IsAutoRepeat());
        return 1;
    }

    /**
     * Returns the [Unit] that casted the [Spell].
     *
     * @return [Unit] caster
     */
    int GetCaster(lua_State* L, Spell* spell)
    {
        Eluna::Push(L, spell->GetCaster());
        return 1;
    }

    /**
     * Returns the cast time of the [Spell].
     *
     * @return int32 castTime
     */
    int GetCastTime(lua_State* L, Spell* spell)
    {
        Eluna::Push(L, spell->GetCastTime());
        return 1;
    }

    /**
     * Returns the entry ID of the [Spell].
     *
     * @return uint32 entryId
     */
    int GetEntry(lua_State* L, Spell* spell)
    {
        Eluna::Push(L, spell->m_spellInfo->Id);
        return 1;
    }

    /**
     * Returns the power cost of the [Spell].
     *
     * @return uint32 powerCost
     */
    int GetPowerCost(lua_State* L, Spell* spell)
    {
        Eluna::Push(L, spell->GetPowerCost()[0].Amount); //< Hackfix for now
        return 1;
    }

    /**
     * Returns the spell duration of the [Spell].
     *
     * @return int32 duration
     */
    int GetDuration(lua_State* L, Spell* spell)
    {
        Eluna::Push(L, spell->GetSpellInfo()->GetDuration());
        return 1;
    }

    /**
     * Returns the target destination coordinates of the [Spell].
     *
     * @return float x : x coordinate of the [Spell]
     * @return float y : y coordinate of the [Spell]
     * @return float z : z coordinate of the [Spell]
     */
    int GetTargetDest(lua_State* L, Spell* spell)
    {
        if (!spell->m_targets.HasDst())
            return 3;
        float x, y, z;
        spell->m_targets.GetDstPos()->GetPosition(x, y, z);

        Eluna::Push(L, x);
        Eluna::Push(L, y);
        Eluna::Push(L, z);
        return 3;
    }

    /**
     * Returns the target [Object] of the [Spell].
     *
     * The target can be any of the following [Object] types:
     * - [Player]
     * - [Creature]
     * - [GameObject]
     * - [Item]
     * - [Corpse]
     *
     * @return [Object] target
     */
    int GetTarget(lua_State* L, Spell* spell)
    {
        if (GameObject* target = spell->m_targets.GetGOTarget())
            Eluna::Push(L, target);
        else if (Item* target = spell->m_targets.GetItemTarget())
            Eluna::Push(L, target);
        else if (Corpse* target = spell->m_targets.GetCorpseTarget())
            Eluna::Push(L, target);
        else if (Unit* target = spell->m_targets.GetUnitTarget())
            Eluna::Push(L, target);
        else if (WorldObject* target = spell->m_targets.GetObjectTarget())
            Eluna::Push(L, target);
        return 1;
    }

    /**
     * Sets the [Spell] to automatically repeat.
     *
     * @param bool repeat : set variable to 'true' for spell to automatically repeat
     */
    int SetAutoRepeat(lua_State* L, Spell* spell)
    {
        bool repeat = Eluna::CHECKVAL<bool>(L, 2);
        spell->SetAutoRepeat(repeat);
        return 0;
    }

    /**
     * Casts the [Spell].
     *
     * @param bool skipCheck = false : skips initial checks to see if the [Spell] can be casted or not, this is optional
     */
    int Cast(lua_State* L, Spell* spell)
    {
        bool skipCheck = Eluna::CHECKVAL<bool>(L, 2, false);
        spell->cast(skipCheck);
        return 0;
    }

    /**
     * Cancels the [Spell].
     */
    int Cancel(lua_State* /*L*/, Spell* spell)
    {
        spell->cancel();
        return 0;
    }

    /**
     * Finishes the [Spell].
     */
    int Finish(lua_State* /*L*/, Spell* spell)
    {
        spell->finish();
        return 0;
    }

    int IsMountSummon(lua_State* L, Spell* spell)
    {
        SpellInfo const* spellInfo = spell->m_spellInfo;
        Eluna::Push(L, (spellInfo->GetEffectMechanic(EFFECT_0) == MECHANIC_MOUNT));
        return 1;
    }

    int GetMountDisplay(lua_State* L, Spell* spell)
    {
        MountEntry const* mountEntry = sDB2Manager.GetMount(spell->m_spellInfo->Id);
        uint32 displayId = 0;
        if (!mountEntry->IsSelfMount())
        {
            DB2Manager::MountXDisplayContainer const* mountDisplays = sDB2Manager.GetMountDisplays(mountEntry->ID);
            DB2Manager::MountXDisplayContainer usableDisplays;
            std::copy(mountDisplays->begin(), mountDisplays->end(), std::back_inserter(usableDisplays));
            displayId = Trinity::Containers::SelectRandomContainerElement(usableDisplays)->CreatureDisplayInfoID;
        }
        Eluna::Push(L, displayId);
        return 1;
    }
};
#endif
