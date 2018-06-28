#include "Configuration/Config.h"
#include "Player.h"
#include "ScriptMgr.h"
#include <iostream>
#include <iomanip>
#include <ctime>
#include <fstream>

using std::stringstream;

class KillStatTracker : public PlayerScript {
public:
  
  stringstream fullStream;
  bool loggingEnabled = sConfigMgr->GetBoolDefault("KillDetailedLogging.enabled", true);
  int logDumpSize = sConfigMgr->GetIntDefault("KillDetailedLogging.dumpSize", 0);

  KillStatTracker() : PlayerScript("KillStatTracker") {

    // If the file doesn't exist we will create it and add the appropriate headers

    std::ifstream ifile("kills.log");
    if (!ifile) {
       fullStream << "timestamp,player,faction,level,maxhealth,currenthealth,creature,creaturefaction,creaturemaxhealth,zoneid,areaid,isgamemaster\n";
       StringDump();
    }

  }

  void OnCreatureKill(Player *player, Creature *killed) override{

    if (loggingEnabled){
      stringstream killStream;

      auto t = std::time(nullptr);
      auto tm = *std::localtime(&t);

      killStream << std::put_time(&tm, "%d-%m-%Y %H-%M-%S") << ",";
      killStream << player->GetName() << "," << player->getFaction() << "," << player->getLevel() << "," << player->GetMaxHealth() << "," << player->GetHealth() << ",";
      killStream << killed->GetName() << "," << killed->getFaction() << "," << killed->GetMaxHealth() << ",";
      killStream << player->GetZoneId() << "," << player->GetAreaId() << "," << player->IsGameMaster();
      killStream << "\n";

      fullStream << killStream.str();
      StringDump();
    }
  }

  void OnPlayerKilledByCreature(Creature* killer, Player* killed) override{

    if (loggingEnabled){
      stringstream killStream;

      auto t = std::time(nullptr);
      auto tm = *std::localtime(&t);

      killStream << std::put_time(&tm, "%d-%m-%Y %H-%M-%S") << ",";
      killStream << killer->GetName() << "," << killer->getFaction() << "," << killer->getLevel() << "," << killer->GetMaxHealth() << "," << killer->GetHealth() << ",";
      killStream << killed->GetName() << "," << killed->getFaction() << "," << killed->GetMaxHealth() << ",";
      killStream << killer->GetZoneId() << "," << killer->GetAreaId() << ",";
      killStream << "\n";

      fullStream << killStream.str();
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
      logFile.open ("kills.log", std::ofstream::app);
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

void AddSC_KillStatTrackerScripts() { 
  new KillStatTracker();
}
