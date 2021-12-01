/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef MODEL_H
#define MODEL_H

#include "vec3d.h"
#include "modelheaders.h"
#include <vector>

class CASCFile;
struct ADTOutputCache;
struct WMODoodadData;
namespace ADT { struct MDDF; struct MODF; }

Vec3D fixCoordSystem(Vec3D const& v);

class Model
{
private:
    void _unload()
    {
        delete[] vertices;
        delete[] indices;
        vertices = NULL;
        indices = NULL;
    }
    std::string filename;
public:
    ModelHeader header;
    Vec3D* vertices;
    uint16* indices;
    AaBox3D bounds;

    bool open();
    bool ConvertToVMAPModel(char const* outfilename);

    Model(std::string& filename);
    ~Model() { _unload(); }
};

namespace Doodad
{
    void Extract(ADT::MDDF const& doodadDef, char const* ModelInstName, uint32 mapID, uint32 originalMapId,
        FILE* pDirfile, std::vector<ADTOutputCache>* dirfileCache);

    void ExtractSet(WMODoodadData const& doodadData, ADT::MODF const& wmo, bool isGlobalWmo, uint32 mapID, uint32 originalMapId,
        FILE* pDirfile, std::vector<ADTOutputCache>* dirfileCache);
}

#endif
