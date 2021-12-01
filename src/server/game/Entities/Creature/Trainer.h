/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef Trainer_h__
#define Trainer_h__

#include "Common.h"
#include <array>
#include <string>
#include <vector>

class Creature;
class ObjectMgr;
class Player;

namespace Trainer
{
    enum class Type : uint32
    {
        None = 0,
        Talent = 1,
        Tradeskill = 2,
        Pet = 3,
    };

    enum class SpellState : uint8
    {
        Known = 0,
        Available = 1,
        Unavailable = 2
    };

    enum class FailReason : uint32
    {
        Unavailable = 0,
        NotEnoughMoney = 1
    };

    struct Spell
    {
        uint32 SpellId = 0;
        uint32 MoneyCost = 0;
        uint32 ReqSkillLine = 0;
        uint32 ReqSkillRank = 0;
        std::array<uint32, 3> ReqAbility = { };
        uint8 ReqLevel = 0;

        uint32 LearnedSpellId = 0;
        bool IsCastable() const { return LearnedSpellId != SpellId; }
    };

    class Trainer
    {
    public:
        Trainer(uint32 id, Type type, std::string greeting, std::vector<Spell> spells);

        void SendSpells(Creature const* npc, Player const* player, LocaleConstant locale) const;
        void TeachSpell(Creature const* npc, Player* player, uint32 spellId) const;

    private:
        Spell const* GetSpell(uint32 spellId) const;
        bool CanTeachSpell(Player const* player, Spell const* trainerSpell) const;
        SpellState GetSpellState(Player const* player, Spell const* trainerSpell) const;
        void SendTeachFailure(Creature const* npc, Player const* player, uint32 spellId, FailReason reason) const;
        std::string const& GetGreeting(LocaleConstant locale) const;

        friend ObjectMgr;
        void AddGreetingLocale(LocaleConstant locale, std::string greeting);

        uint32 _id;
        Type _type;
        std::vector<Spell> _spells;
        std::array<std::string, TOTAL_LOCALES> _greeting;
    };
}

#endif // Trainer_h__
