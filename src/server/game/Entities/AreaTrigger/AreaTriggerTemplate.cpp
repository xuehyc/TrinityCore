/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "AreaTriggerTemplate.h"
#include <G3D/Vector3.h>
#include <algorithm>
#include <cstring>
#include <cmath>

AreaTriggerScaleInfo::AreaTriggerScaleInfo()
{
    memset(Data.Raw, 0, sizeof(Data.Raw));
}

AreaTriggerTemplate::AreaTriggerTemplate()
{
    Id = 0;
    Type = AREATRIGGER_TYPE_MAX;
    Flags = 0;
    ScriptId = 0;
    MaxSearchRadius = 0.0f;

    memset(DefaultDatas.Data, 0, sizeof(DefaultDatas.Data));
}

AreaTriggerTemplate::~AreaTriggerTemplate()
{
}

// Init the MaxSearchRadius that will be used in MobiusSearcher, avoiding calculate it at each update
void AreaTriggerTemplate::InitMaxSearchRadius()
{
    switch (Type)
    {
        case AREATRIGGER_TYPE_SPHERE:
        {
            MaxSearchRadius = std::max(SphereDatas.Radius, SphereDatas.RadiusTarget);
            break;
        }
        case AREATRIGGER_TYPE_BOX:
        {
            MaxSearchRadius = std::sqrt(BoxDatas.Extents[0] * BoxDatas.Extents[0] / 4 + BoxDatas.Extents[1] * BoxDatas.Extents[1] / 4);
            break;
        }
        case AREATRIGGER_TYPE_POLYGON:
        {
            if (PolygonDatas.Height <= 0.0f)
                PolygonDatas.Height = 1.0f;

            Position center(0.0f, 0.0f);
            for (TaggedPosition<Position::XY> const& vertice : PolygonVertices)
            {
                float pointDist = center.GetExactDist2d(vertice);

                if (pointDist > MaxSearchRadius)
                    MaxSearchRadius = pointDist;
            }

            break;
        }
        case AREATRIGGER_TYPE_CYLINDER:
        {
            MaxSearchRadius = CylinderDatas.Radius;
            break;
        }
        default:
            break;
    }
}

AreaTriggerMiscTemplate::AreaTriggerMiscTemplate()
{
    MiscId = 0;
    AreaTriggerEntry = 0;

    MoveCurveId = 0;
    ScaleCurveId = 0;
    MorphCurveId = 0;
    FacingCurveId = 0;

    AnimId = 0;
    AnimKitId = 0;

    DecalPropertiesId = 0;

    TimeToTarget = 0;
    TimeToTargetScale = 0;

    // legacy code from before it was known what each curve field does
    // wtf? thats not how you pack curve data
    float tmp = 1.0000001f;
    memcpy(&ExtraScale.Data.Raw[5], &tmp, sizeof(tmp));
    // also OverrideActive does nothing on ExtraScale
    ExtraScale.Data.Structured.OverrideActive = 1;

    Template = nullptr;
}

AreaTriggerMiscTemplate::~AreaTriggerMiscTemplate()
{
}

bool AreaTriggerMiscTemplate::HasSplines() const
{
    return SplinePoints.size() >= 2;
}
