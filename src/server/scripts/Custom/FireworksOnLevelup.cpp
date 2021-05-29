/*
Fireworks on levelup Module
Original Module by Conanhun
Modified by SPP DEV MDIC
For Gwenpool 434 Branch.
*/

#include "Chat.h" // We need this for the chat broadcast to be recognize if you desire chat broad cast
#include "Config.h" //we need this for the sConfigMgr to be recognized below
#include "Player.h" //we need this for the Player* player to be Recognize
#include "ScriptMgr.h" // We Need this PlayerScript to be Recognize
#include "World.h" // We need this for the sWorld to be Recognize

class FireWorksOnLevelUp : public PlayerScript
{
public:
    FireWorksOnLevelUp() : PlayerScript("FireWorksOnLevelUp") { } //playerscript name that has to be unique.
    void OnLevelChanged(Player* player, uint8 oldLevel) // we chose this for the leveling up of player from their old level.
    {// below we create the conf switch that only exsist here in this module and now where else.
        if (sConfigMgr->GetBoolDefault("FireWorksOnLevelUp", true))
            // we establish the conf of FireWorksOnLevelUp = 1
            //Just remember 1 is being true. 0 is being false. We define what happens when it is set to true and also true will be default with no Conf present
        {
            if (oldLevel == 79)// former level to be before being trigger
            {
                player->CastSpell(player, 30161, true); //currently is it a purple firework spell id being shot up when you level up to 80 from 79
                //Below is if you want a auto announce simular to the Login Announcer to follow after the fireworks to annoucne to the server.
                std::ostringstream lu; //this establishes a lu.str().c_str()
                lu << "|cff3DAEFF[ SPP Cata Announcer ]|cffFFD800 : Player|cff4CFF00 " << player->GetName() << " |cffFFD800has leveled up to|cffFFD800 80!";//defines the LU string message
                sWorld->SendServerMessage(SERVER_MSG_STRING, lu.str().c_str()); // sends the broadcast string message server wide
            }
            if (oldLevel == 84)// former level to be before being trigger
            {
                player->CastSpell(player, 30161, true); //currently is it a purple firework spell id being shot up when you level up to 85 from 84
                //Below is a literal copy and paste of the above. If you want it to be active with the message broadcast then remove the //
                //std::ostringstream lu; //this establishes a lu.str().c_str()
                //lu << "|cff3DAEFF[ SPP Cata Announcer ]|cffFFD800 : Player|cff4CFF00 " << player->GetName() << " |cffFFD800has leveled up to|cffFFD800 85!";//defines the LU string message
                //sWorld->SendServerMessage(SERVER_MSG_STRING, lu.str().c_str()); // sends the broadcast string message server wide
            }
        }
    }
};

void AddSC_FireWorksOnLevelUp() //Add this to the Custom_script_loader.cpp
{
    new FireWorksOnLevelUp();
}
