/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
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

#ifndef _MAIL_EXTERNAL_H
#define _MAIL_EXTERNAL_H

#include "Common.h"

class WH_GAME_API MailExternal
{
public:
    static MailExternal* instance();

    void Initialize();
    void Update(uint32 diff);
    void AddMail(std::string_view charName, std::string_view thanksSubject, std::string_view thanksText, uint32 money, uint32 itemID, uint32 itemCount, uint32 creatureEntry);

private:
    void SendMails();
    void GetMailsFromDB();
};

#define sMailExternal MailExternal::instance()

#endif // _MAILEXTERNAL_H
