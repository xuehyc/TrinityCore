#include "Configuration/Config.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Group.h"
#include <iostream>
#include <iomanip>
#include <ctime>
#include <fstream>

using std::stringstream;

class ZoneAreaTracker : public PlayerScript {
public:
  stringstream fullStream;
  bool loggingEnabled = sConfigMgr->GetBoolDefault("ZoneAreaDetailedLogging.enabled", true);
  int logDumpSize = sConfigMgr->GetIntDefault("ZoneAreaDetailedLogging.dumpSize", 0);

  ZoneAreaTracker() : PlayerScript("ZoneAreaTracker") { 

    // If the file doesn't exist we will create it and add the appropriate headers

    std::ifstream ifile("zonearea.log");
    if (!ifile) {
      fullStream << "timestamp,player,faction,level,maxhealth,currenthealth,newzone,newarea,ingroup,inraid\n";
      StringDump();
    }
}

  void OnUpdateZone(Player* player, uint32 newZone, uint32 oldZone, uint32 newArea) override{

    if (loggingEnabled){
      stringstream zoneStream;

      auto t = std::time(nullptr);
      auto tm = *std::localtime(&t);

      Group* group = player->GetGroup();

      zoneStream << std::put_time(&tm, "%d-%m-%Y %H-%M-%S") << ",";
      zoneStream << player->GetName() << "," << player->getFaction() << "," << player->getLevel() << "," << player->GetMaxHealth() << "," << player->GetHealth() << ",";
      zoneStream << newZone << "," << newArea << (group != NULL) << ",";

      if (group != NULL){
        zoneStream << group->isRaidGroup();
      } else {
        zoneStream << "false";
      }

      zoneStream << "\n";

      fullStream << zoneStream.str();
      StringDump();
    }
  }

  void OnUpdateArea(Player *player, uint32 oldArea, uint32 newArea) override{

    if (loggingEnabled){
      stringstream areaStream;

      auto t = std::time(nullptr);
      auto tm = *std::localtime(&t);

      Group* group = player->GetGroup();

      areaStream << std::put_time(&tm, "%d-%m-%Y %H-%M-%S") << ",";
      areaStream << player->GetName() << "," << player->getFaction() << "," << player->getLevel() << "," << player->GetMaxHealth() << "," << player->GetHealth() << ",";
      areaStream << "000000" << "," << newArea << (group != NULL) << ",";

      if (group != NULL){
        areaStream << group->isRaidGroup();
      } else {
        areaStream << "false";
      }

      areaStream << "\n";

      fullStream << areaStream.str();
      StringDump();
    }
  }

private:

  int insertCount = 0;

  void StringDump(){

    insertCount++;

    if (insertCount > logDumpSize){
      // Dump to log
      std::ofstream logFile;
      logFile.open ("zonearea.log", std::ofstream::app);
      logFile << fullStream.rdbuf();
      logFile.close();

      // Reset the buffer
      fullStream.str("");
      fullStream.clear();

      // Reset line count
      insertCount = 0;
    }
  }
};

void AddSC_ZoneAreaTrackerScripts() { 
  new ZoneAreaTracker(); 
}
