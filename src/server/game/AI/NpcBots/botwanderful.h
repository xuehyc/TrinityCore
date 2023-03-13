#ifndef BOTWANDERFUL_H_
#define BOTWANDERFUL_H_

#include "Position.h"

#include <list>
#include <unordered_map>

/*
NpcBot System by Trickerer (onlysuffering@gmail.com)
Original patch from: LordPsyan https://bitbucket.org/lordpsyan/trinitycore-patches/src/3b8b9072280e/Individual/11185-BOTS-NPCBots.patch
*/

class Creature;

enum class BotWPFlags : uint32
{
    BOTWP_FLAG_SPAWN            = 0x00000001,
    BOTWP_FLAG_ALLIANCE_ONLY    = 0x00000002,
    BOTWP_FLAG_HORDE_ONLY       = 0x00000004,
    BOTWP_FLAG_CAN_BACKTRACK_TO = 0x00000008,
    BOTWP_FLAG_END              = 0x00000010
};

class WanderNode : public Position
{
    using node_ltype = std::list<WanderNode*>;
    using node_mtype = std::unordered_map<uint32, node_ltype>;

    static node_ltype ALL_WPS;
    static node_mtype ALL_WPS_PER_MAP;
    static node_mtype ALL_WPS_PER_ZONE;
    static node_mtype ALL_WPS_PER_AREA;

public:
    static node_ltype const* GetAllWPs() {
        return &ALL_WPS;
    }
    static node_ltype const* GetContainerWPs(node_mtype const& c, uint32 key) {
        node_mtype::const_iterator ci = c.find(key);
        return ci == c.cend() ? nullptr : &ci->second;
    }
    inline static node_ltype const* GetMapWPs(uint32 mapId) { return GetContainerWPs(ALL_WPS_PER_MAP, mapId); }
    inline static node_ltype const* GetZoneWPs(uint32 zoneId) { return GetContainerWPs(ALL_WPS_PER_ZONE, zoneId); }
    inline static node_ltype const* GetAreaWPs(uint32 areaId) { return GetContainerWPs(ALL_WPS_PER_AREA, areaId); }
    static bool IsWP(Creature const* creature) {
        return creature && std::find_if(ALL_WPS.cbegin(), ALL_WPS.cend(), [=](WanderNode const* wp) {
            return wp->GetCreature() == creature;
        }) != ALL_WPS.cend();
    }
    static WanderNode* FindInAllWPs(uint32 wpId) {
        auto ci = std::find_if(ALL_WPS.cbegin(), ALL_WPS.cend(), [wpId = wpId](WanderNode const* wp) {
            return wp->GetWPId() == wpId;
        });
        return ci == ALL_WPS.cend() ? nullptr : *ci;
    }
    static WanderNode* FindInAllWPs(Creature const* creature) {
        if (!creature) return nullptr;
        auto ci = std::find_if(ALL_WPS.cbegin(), ALL_WPS.cend(), [=](WanderNode const* wp) {
            return wp->GetCreature() == creature;
        });
        return ci == ALL_WPS.cend() ? nullptr : *ci;
    }
    static WanderNode* FindInMapWPs(Creature const* creature, uint32 mapId) {
        if (!creature) return nullptr;
        auto cim = ALL_WPS_PER_MAP.find(mapId);
        if (cim == ALL_WPS_PER_MAP.cend())
            return nullptr;
        auto ci = std::find_if(ALL_WPS_PER_MAP.at(mapId).cbegin(), ALL_WPS_PER_MAP.at(mapId).cend(), [=](WanderNode const* wp) {
            return wp->GetCreature() == creature;
        });
        return ci == ALL_WPS_PER_MAP.at(mapId).cend() ? nullptr : *ci;
    }
    static WanderNode* FindInMapWPs(uint32 wpId, uint32 mapId) {
        auto cim = ALL_WPS_PER_MAP.find(mapId);
        if (cim == ALL_WPS_PER_MAP.cend())
            return nullptr;
        auto ci = std::find_if(ALL_WPS_PER_MAP.at(mapId).cbegin(), ALL_WPS_PER_MAP.at(mapId).cend(), [wpId = wpId](WanderNode const* wp) {
            return wp->GetWPId() == wpId;
        });
        return ci == ALL_WPS_PER_MAP.at(mapId).cend() ? nullptr : *ci;
    }

    WanderNode(uint32 wpId, uint32 mapId, float x, float y, float z, float o, uint32 zoneId, uint32 areaId, std::string const& name);
    ~WanderNode();

    void SetCreature(Creature* creature);
    Creature* GetCreature() const;

    std::string FormatLinks() const;

    void Link(WanderNode* wp) {
        if (!HasLink(wp)) {
            _links.push_back(wp);
            wp->Link(this);
        }
    }
    void UnLink(WanderNode* wp) {
        if (HasLink(wp)) {
            _links.remove(wp);
            wp->UnLink(this);
        }
    }
    bool HasLink(WanderNode const* wp) const {
        return std::find(_links.cbegin(), _links.cend(), wp) != _links.cend();
    }
    auto GetLinks() const -> typename std::add_const_t<WanderNode::node_ltype>& {
        return _links;
    }

    void SetLevels(uint8 minLevel, uint8 maxLevel) {
        std::tie(_minLevel, _maxLevel) = { minLevel, maxLevel };
    }

    void SetFlags(BotWPFlags flags);
    void RemoveFlags(BotWPFlags flags);
    bool HasFlag(BotWPFlags flags) const;

    std::string ToString() const;

    uint32 GetWPId() const { return _wpId; }
    uint32 GetMapId() const { return _mapId; }
    uint32 GetZoneId() const { return _zoneId; }
    uint32 GetAreaId() const { return _areaId; }
    std::string const& GetName() const { return _name; }
    std::pair<uint8, uint8> GetLevels() const { return { _minLevel, _maxLevel }; }
    uint32 GetFlags() const { return _flags; }

private:
    const uint32 _wpId;
    const uint32 _mapId;
    const uint32 _zoneId;
    const uint32 _areaId;
    const std::string _name;
    uint8 _minLevel;
    uint8 _maxLevel;
    uint32 _flags;

    node_ltype _links;

    Creature* _creature;
};

#endif //BOTWANDERFUL_H_
