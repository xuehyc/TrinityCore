/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CHARACTERDATABASECLEANER_H
#define CHARACTERDATABASECLEANER_H

namespace CharacterDatabaseCleaner
{
    enum CleaningFlags
    {
        CLEANING_FLAG_ACHIEVEMENT_PROGRESS  = 0x1,
        CLEANING_FLAG_SKILLS                = 0x2,
        CLEANING_FLAG_SPELLS                = 0x4,
        CLEANING_FLAG_TALENTS               = 0x8,
        CLEANING_FLAG_QUESTSTATUS           = 0x10
    };

    GAME_API void CleanDatabase();

    GAME_API void CheckUnique(const char* column, const char* table, bool (*check)(uint32));

    GAME_API bool AchievementProgressCheck(uint32 criteria);
    GAME_API bool SkillCheck(uint32 skill);
    GAME_API bool SpellCheck(uint32 spell_id);
    GAME_API bool TalentCheck(uint32 talent_id);

    GAME_API void CleanCharacterAchievementProgress();
    GAME_API void CleanCharacterSkills();
    GAME_API void CleanCharacterSpell();
    GAME_API void CleanCharacterTalent();
    GAME_API void CleanCharacterQuestStatus();
}

#endif
