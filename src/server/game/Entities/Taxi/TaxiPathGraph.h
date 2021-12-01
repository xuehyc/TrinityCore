/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef TAXIPATHGRAPH_HPP
#define TAXIPATHGRAPH_HPP

#include "Position.h"
#include "Define.h"
#include <boost/graph/adjacency_list.hpp>

class Player;
struct TaxiNodesEntry;

class GAME_API TaxiPathGraph
{
public:
    static TaxiPathGraph& Instance();

    void Initialize();
    std::size_t GetCompleteNodeRoute(TaxiNodesEntry const* from, TaxiNodesEntry const* to, Player const* player, std::vector<uint32>& shortestPath);

private:
    struct EdgeCost
    {
        TaxiNodesEntry const* To;
        uint32 Distance;
        uint32 EvaluateDistance(Player const* player) const;
    };
    typedef boost::adjacency_list<boost::vecS, boost::vecS, boost::directedS, boost::property<boost::vertex_index_t, uint32>, boost::property<boost::edge_weight_t, EdgeCost>> Graph;
    typedef boost::property_map<Graph, boost::edge_weight_t>::type WeightMap;
    typedef Graph::vertex_descriptor vertex_descriptor;
    typedef Graph::edge_descriptor edge_descriptor;
    typedef std::pair<vertex_descriptor, vertex_descriptor> edge;

    TaxiPathGraph() { }
    ~TaxiPathGraph() { }

    void AddVerticeAndEdgeFromNodeInfo(TaxiNodesEntry const* from, TaxiNodesEntry const* to, uint32 pathId, std::vector<std::pair<edge, EdgeCost>>& edges);
    vertex_descriptor GetVertexIDFromNodeID(TaxiNodesEntry const* node);
    uint32 GetNodeIDFromVertexID(vertex_descriptor vertexID);
    vertex_descriptor CreateVertexFromFromNodeInfoIfNeeded(TaxiNodesEntry const* node);
    std::size_t GetVertexCount();

    Graph m_graph;
    std::vector<TaxiNodesEntry const*> m_vertices;

    TaxiPathGraph(TaxiPathGraph const&) = delete;
    TaxiPathGraph& operator=(TaxiPathGraph const&) = delete;
};

#define sTaxiPathGraph TaxiPathGraph::Instance()

#endif    /* TAXIPATHGRAPH_HPP */
