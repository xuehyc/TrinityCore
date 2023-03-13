#include "botwanderful.h"
#include "DBCStores.h"
#include "TemporarySummon.h"

#include <iomanip>

#ifdef _MSC_VER
# pragma warning(push, 4)
#endif

WanderNode::node_ltype WanderNode::ALL_WPS = {};
WanderNode::node_mtype WanderNode::ALL_WPS_PER_MAP = {};
WanderNode::node_mtype WanderNode::ALL_WPS_PER_ZONE = {};
WanderNode::node_mtype WanderNode::ALL_WPS_PER_AREA = {};

WanderNode::WanderNode(uint32 wpId, uint32 mapId, float x, float y, float z, float o, uint32 zoneId, uint32 areaId, std::string const& name)
    : Position(x, y, z, o),
    _wpId(wpId), _mapId(mapId), _zoneId(zoneId), _areaId(areaId), _name(name), _minLevel(1u), _maxLevel(MAX_LEVEL), _flags(0),
    _creature(nullptr)
{
    ASSERT_NOTNULL(sMapStore.LookupEntry(_mapId));
    ASSERT_NOTNULL(sAreaTableStore.LookupEntry(_zoneId));
    ASSERT_NOTNULL(sAreaTableStore.LookupEntry(_areaId));
    ALL_WPS.push_back(this);
    ALL_WPS_PER_MAP[_mapId].push_back(this);
    ALL_WPS_PER_ZONE[_zoneId].push_back(this);
    ALL_WPS_PER_AREA[_areaId].push_back(this);
}

WanderNode::~WanderNode() {
    ALL_WPS_PER_AREA.at(_areaId).remove(this);
    ALL_WPS_PER_ZONE.at(_zoneId).remove(this);
    ALL_WPS_PER_MAP.at(_mapId).remove(this);
    ALL_WPS.remove(this);
    while (!_links.empty())
        UnLink(_links.front());
    if (_creature && _creature->IsInWorld())
        _creature->ToTempSummon()->DespawnOrUnsummon();
}

void WanderNode::SetCreature(Creature* creature)
{
    if (creature != nullptr)
        ASSERT(!_creature);
    _creature = creature;
}

Creature* WanderNode::GetCreature() const
{
    return _creature;
}

std::string WanderNode::FormatLinks() const
{
    std::ostringstream lss;
    for (WanderNode* lwp : _links)
        lss << lwp->GetWPId() << ":0 "; //TODO: chance
    return lss.str();
}


void WanderNode::SetFlags(BotWPFlags flags)
{
    _flags |= AsUnderlyingType(flags);
}

void WanderNode::RemoveFlags(BotWPFlags flags)
{
    _flags &= ~AsUnderlyingType(flags);
}

bool WanderNode::HasFlag(BotWPFlags flags) const
{
    return !!(_flags & AsUnderlyingType(flags));
}

std::string WanderNode::ToString() const
{
    std::ostringstream wps;
    wps << "WP " << _wpId << " '" << _name << "', " << uint32(_links.size()) << " link(s)" << ", Map " << _mapId
        << ", Zone " << _zoneId << " (" << std::string(sAreaTableStore.LookupEntry(_zoneId)->AreaName[0])
        << "), Area " << _areaId << " (" << std::string(sAreaTableStore.LookupEntry(_areaId)->AreaName[0])
        << "), minLvl " << uint32(_minLevel) << ", maxLvl " << uint32(_maxLevel)
        << " (" << static_cast<Position const*>(this)->ToString() << ')'
        << ", flags: 0x" << std::hex << std::setw(8) << std::setfill('0') << _flags << std::dec;

    return wps.str();
}

#ifdef _MSC_VER
# pragma warning(pop)
#endif
