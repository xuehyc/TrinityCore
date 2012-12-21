/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
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

#include "BattlegroundAB.h"
#include "BattlegroundWS.h"
#include "BattlegroundIC.h"
#include "BattlegroundSA.h"
#include "BattlegroundAV.h"
#include "Vehicle.h"

#include "OutdoorPvPWG.h"
#include "OutdoorPvPMgr.h"

class achievement_resilient_victory : public AchievementCriteriaScript
{
    public:
        achievement_resilient_victory() : AchievementCriteriaScript("achievement_resilient_victory") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            if (!bg)
                return false;

            if (bg->GetTypeID(true) != BATTLEGROUND_AB)
                return false;

            if (!static_cast<BattlegroundAB*>(bg)->IsTeamScores500Disadvantage(source->GetTeam()))
                return false;

            return true;
        }
};

class achievement_bg_control_all_nodes : public AchievementCriteriaScript
{
    public:
        achievement_bg_control_all_nodes() : AchievementCriteriaScript("achievement_bg_control_all_nodes") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            if (!bg)
                return false;

            if (!bg->IsAllNodesConrolledByTeam(source->GetTeam()))
                return false;

            return true;
        }
};

class achievement_save_the_day : public AchievementCriteriaScript
{
    public:
        achievement_save_the_day() : AchievementCriteriaScript("achievement_save_the_day") { }

        bool OnCheck(Player* source, Unit* target)
        {
            if (!target)
                return false;

            if (Player const* player = target->ToPlayer())
            {
                Battleground* bg = source->GetBattleground();
                if (!bg)
                    return false;

                if (bg->GetTypeID(true) != BATTLEGROUND_WS)
                    return false;

                if (static_cast<BattlegroundWS*>(bg)->GetFlagState(player->GetTeam()) == BG_WS_FLAG_STATE_ON_BASE)
                    return true;
            }
            return false;
        }
};

class achievement_bg_ic_resource_glut : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_resource_glut() : AchievementCriteriaScript("achievement_bg_ic_resource_glut") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (source->HasAura(SPELL_OIL_REFINERY) && source->HasAura(SPELL_QUARRY))
                return true;

            return false;
        }
};

class achievement_bg_ic_glaive_grave : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_glaive_grave() : AchievementCriteriaScript("achievement_bg_ic_glaive_grave") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (Creature* vehicle = source->GetVehicleCreatureBase())
            {
                if (vehicle->GetEntry() == NPC_GLAIVE_THROWER_H ||  vehicle->GetEntry() == NPC_GLAIVE_THROWER_A)
                    return true;
            }

            return false;
        }
};

class achievement_bg_ic_mowed_down : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_mowed_down() : AchievementCriteriaScript("achievement_bg_ic_mowed_down") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (Creature* vehicle = source->GetVehicleCreatureBase())
            {
                if (vehicle->GetEntry() == NPC_KEEP_CANNON)
                    return true;
            }

            return false;
        }
};

class achievement_bg_sa_artillery : public AchievementCriteriaScript
{
    public:
        achievement_bg_sa_artillery() : AchievementCriteriaScript("achievement_bg_sa_artillery") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (Creature* vehicle = source->GetVehicleCreatureBase())
            {
                if (vehicle->GetEntry() == NPC_ANTI_PERSONNAL_CANNON)
                    return true;
            }

            return false;
        }
};

class achievement_arena_kills : public AchievementCriteriaScript
{
    public:
        achievement_arena_kills(char const* name, uint8 arenaType) : AchievementCriteriaScript(name),
            _arenaType(arenaType)
        {
        }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            // this checks GetBattleground() for NULL already
            if (!source->InArena())
                return false;

            return source->GetBattleground()->GetArenaType() == _arenaType;
        }

    private:
        uint8 const _arenaType;
};

class achievement_sickly_gazelle : public AchievementCriteriaScript
{
public:
    achievement_sickly_gazelle() : AchievementCriteriaScript("achievement_sickly_gazelle") { }

    bool OnCheck(Player* /*source*/, Unit* target)
    {
        if (!target)
            return false;

        if (Player* victim = target->ToPlayer())
            if (victim->IsMounted())
                return true;

        return false;
    }
};

class achievement_everything_counts : public AchievementCriteriaScript
{
    public:
        achievement_everything_counts() : AchievementCriteriaScript("achievement_everything_counts") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            if (!bg)
                return false;

            if (bg->GetTypeID(true) != BATTLEGROUND_AV)
                return false;

            if (static_cast<BattlegroundAV*>(bg)->IsBothMinesControlledByTeam(source->GetTeam()))
                return true;

            return false;
        }
};

class achievement_bg_av_perfection : public AchievementCriteriaScript
{
    public:
        achievement_bg_av_perfection() : AchievementCriteriaScript("achievement_bg_av_perfection") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            if (!bg)
                return false;

            if (bg->GetTypeID(true) != BATTLEGROUND_AV)
                return false;

            if (static_cast<BattlegroundAV*>(bg)->IsAllTowersControlledAndCaptainAlive(source->GetTeam()))
                return true;

            return false;
        }
};

class achievement_wg_didnt_stand_a_chance : public AchievementCriteriaScript
{
public:
    achievement_wg_didnt_stand_a_chance() : AchievementCriteriaScript("achievement_wg_didnt_stand_a_chance") { }

    bool OnCheck(Player* source, Unit* target)
    {
        if (!target)
            return false;

        if (Player* victim = target->ToPlayer())
        {
            if (!victim->IsMounted())
                return false;

            if (Vehicle* vehicle = source->GetVehicle())
                if (vehicle->GetBase()->GetEntry() == 28366) // Wintergrasp Tower Cannon
                    return true;
        }

        return false;
    }
};

class achievement_wg_vehicular_gnomeslaughter : public AchievementCriteriaScript
{
public:
    achievement_wg_vehicular_gnomeslaughter() : AchievementCriteriaScript("achievement_wg_vehicular_gnomeslaughter") { }

    bool OnCheck(Player* source, Unit* target)
    {
        if (!target)
            return false;

        if (Player* victim = target->ToPlayer())
            if (Vehicle* vehicle = source->GetVehicle())
                switch (vehicle->GetBase()->GetEntry())
                {
                    case 27881: // must be in Vehicle oder (Vehicle- or Tower-) Cannon
                    case 28094:
                    case 28312:
                    case 28319:
                    case 32627:
                    case 32629:
                    case 28366:
                        return true;
                    default:
                        break;
                }

        return false;
    }
};

class achievement_wg_within_our_grasp : public AchievementCriteriaScript
{
public:
    achievement_wg_within_our_grasp() : AchievementCriteriaScript("achievement_wg_within_our_grasp") { }

    bool OnCheck(Player* /*source*/, Unit* /*target*/)
    {
        if (OutdoorPvPWG *wg = (OutdoorPvPWG*)sOutdoorPvPMgr->GetOutdoorPvPToZoneId(4197))
            return wg->WithinOurGraspEligible();
        return false;
    }
};

class achievement_bg_sa_defense_of_ancients : public AchievementCriteriaScript
{
    public:
        achievement_bg_sa_defense_of_ancients() : AchievementCriteriaScript("achievement_bg_sa_defense_of_ancients")
        {
        }

        bool OnCheck(Player* player, Unit* /*target*/)
        {
            if (!player)
                return false;

            Battleground* battleground = player->GetBattleground();
            if (!battleground)
                return false;

            if (player->GetTeamId() == static_cast<BattlegroundSA*>(battleground)->Attackers)
                return false;

            if (!static_cast<BattlegroundSA*>(battleground)->gateDestroyed)
                return true;

            return false;
        }
};

enum ArgentTournamentAreas
{
    AREA_ARGENT_TOURNAMENT_FIELDS  = 4658,
    AREA_RING_OF_ASPIRANTS         = 4670,
    AREA_RING_OF_ARGENT_VALIANTS   = 4671,
    AREA_RING_OF_ALLIANCE_VALIANTS = 4672,
    AREA_RING_OF_HORDE_VALIANTS    = 4673,
    AREA_RING_OF_CHAMPIONS         = 4669,
};

class achievement_tilted : public AchievementCriteriaScript
{
    public:
        achievement_tilted() : AchievementCriteriaScript("achievement_tilted") {}

        bool OnCheck(Player* player, Unit* /*target*/)
        {
            bool checkArea = player->GetAreaId() == AREA_ARGENT_TOURNAMENT_FIELDS ||
                                player->GetAreaId() == AREA_RING_OF_ASPIRANTS ||
                                player->GetAreaId() == AREA_RING_OF_ARGENT_VALIANTS ||
                                player->GetAreaId() == AREA_RING_OF_ALLIANCE_VALIANTS ||
                                player->GetAreaId() == AREA_RING_OF_HORDE_VALIANTS ||
                                player->GetAreaId() == AREA_RING_OF_CHAMPIONS;

            return player && checkArea && player->duel && player->duel->isMounted;
        }
};

class achievement_not_even_a_scratch : public AchievementCriteriaScript
{
    public:
        achievement_not_even_a_scratch() : AchievementCriteriaScript("achievement_not_even_a_scratch") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            Battleground* battleground = source->GetBattleground();
            if (!battleground)
                return false;

            if (static_cast<BattlegroundSA*>(battleground)->notEvenAScratch(source->GetTeam()))
                return true;

            return false;
        }
};

class achievement_brew_of_the_month_club : public AchievementCriteriaScript
{
    public:
        achievement_brew_of_the_month_club(char const* name, uint32 quest) : AchievementCriteriaScript(name),
            _questEntry(quest)
        {
        }

        bool OnCheck(Player* player, Unit* target)
        {
            if (!player)
                return false;

            // this is a duplicated criteria check but we need it since we are not
            // really doing any check here but just use this as a hook to send out
            // the achievement related mails.
            if (!player->GetQuestRewardStatus(_questEntry))
                return false;

            // if we are here we need to create the mail for the stupid brew of the year club
            uint32 brew_of_the_month_beers[12] = {37496, 37497, 37498, 37499, 37488, 37489, 37490, 37491, 37492, 37493, 37494, 37495}; // sep-aug
            uint32 delay = 0;
            for (uint8 iter = 0; iter < 12; ++iter)
            {
                Item* item = brew_of_the_month_beers[iter] ? Item::CreateItem(brew_of_the_month_beers[iter], 1, player) : NULL;

                // subject and text
                std::string subject = "Bräu des Monats!";
                std::string text = "Deine monatliche Bier-Lieferung befindet sich im Anhang.$B$BProst!";

                MailDraft draft(subject, text);

                SQLTransaction trans = CharacterDatabase.BeginTransaction();
                if (item)
                {
                    // save new item before send
                    item->SaveToDB(trans); // save for prevent lost at next mail load, if send fail then item will deleted

                    // item
                    draft.AddItem(item);
                }

                draft.SendMailTo(trans, player, MailSender(MAIL_CREATURE, 28329), MAIL_CHECK_MASK_HAS_BODY, delay);
                CharacterDatabase.CommitTransaction(trans);

                // TODO calculate correct send times
                delay += 30*86400;
            }
            sLog->outInfo(LOG_FILTER_TSCR, "Player %s achieved Brew of the Month Club and has 12 mails added with beer over the next 12 month.", player->GetName());
            return true;
        }
    private:
        uint32 const _questEntry;
};

void AddSC_achievement_scripts()
{
    new achievement_resilient_victory();
    new achievement_bg_control_all_nodes();
    new achievement_save_the_day();
    new achievement_bg_ic_resource_glut();
    new achievement_bg_ic_glaive_grave();
    new achievement_bg_ic_mowed_down();
    new achievement_bg_sa_artillery();
    new achievement_sickly_gazelle();
    new achievement_wg_didnt_stand_a_chance();
    new achievement_everything_counts();
    new achievement_bg_av_perfection();
    new achievement_arena_kills("achievement_arena_2v2_kills", ARENA_TYPE_2v2);
    new achievement_arena_kills("achievement_arena_3v3_kills", ARENA_TYPE_3v3);
    new achievement_arena_kills("achievement_arena_5v5_kills", ARENA_TYPE_5v5);
    new achievement_bg_sa_defense_of_ancients();
    new achievement_tilted();
    new achievement_not_even_a_scratch();
    new achievement_wg_vehicular_gnomeslaughter();
    new achievement_wg_within_our_grasp();
    new achievement_brew_of_the_month_club("achievement_brew_of_the_month_q12420", 12420);
    new achievement_brew_of_the_month_club("achievement_brew_of_the_month_q12421", 12421);
    new achievement_brew_of_the_month_club("achievement_brew_of_the_month_q12278", 12278);
    new achievement_brew_of_the_month_club("achievement_brew_of_the_month_q12306", 12306);
}
