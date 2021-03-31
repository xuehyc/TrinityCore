3789, :x 65.30257415771484, :map 1, :guid 3}, :area s000ds, :interval
1414478700, :timestamp 1414478864, :event-type EVENT_TYPE_PLAYER_UPDATE,
:lng 0.11713197082281113}
{:geohash s000dsv3c75z, :sector s000dsv, :num-values [0 0], :app
EVENT_TYPE_PLAYER_UPDATE, :lat 0.1143009141087532, :player {:y
-2765.752685546875, :description X: 65.3026 Y: -2765.75 Z: 96.6021 O:
1.33121, :o 1.3312122821807861, :name Tranchis, :level 80, :z
96.60212707519531, :x 65.30257415771484, :map 1, :guid 3}, :area s000ds,
:interval 1414478700, :timestamp 1414478865, :event-type
EVENT_TYPE_PLAYER_UPDATE, :lng 0.11713197082281113}
{:geohash s000dsv3c75z, :sector s000dsv, :num-values [0 0], :app
EVENT_TYPE_PLAYER_UPDATE, :lat 0.1143009141087532, :player {:y
-2765.752685546875, :description X: 65.3026 Y: -2765.75 Z: 95.0357 O:
1.33121, :o 1.3312122821807861, :name Tranchis, :level 80, :z
95.0357437133789, :x 65.30257415771484, :map 1, :guid 3}, :area s000ds,
:interval 1414478700, :timestamp 1414478865, :event-type
EVENT_TYPE_PLAYER_UPDATE, :lng 0.11713197082281113}
{:geohash s000dsv613r8, :sector s000dsv, :num-values [0 0], :app
EVENT_TYPE_PLAYER_UPDATE, :lat 0.11433330178260803, :player {:y
-2733.36376953125, :description X: 70.35 Y: -2733.36 Z: 94.3298 O:
1.47023, :o 1.470227837562561, :name Tranchis, :level 80, :z
94.3298110961914, :x 70.35002136230469, :map 1, :guid 3}, :area s000ds,
:interval 1414478700, :timestamp 1414478937, :event-type
EVENT_TYPE_PLAYER_UPDATE, :lng 0.11713701486587524}
{:geohash s000dsv613r8, :sector s000dsv, :num-values [0 0], :app
EVENT_TYPE_PLAYER_UPDATE, :lat 0.11433330178260803, :player {:y
-2733.36376953125, :description X: 70.35 Y: -2733.36 Z: 92.7634 O:
1.47023, :o 1.470227837562561, :name Tranchis, :level 80, :z
92.76341247558594, :x 70.35002136230469, :map 1, :guid 3}, :area s000ds,
:interval 1414478700, :timestamp 1414478937, :event-type
EVENT_TYPE_PLAYER_UPDATE, :lng 0.11713701486587524}
{:test "ok", :actions ()}
{:geohash s000dsv613r8, :sector s000dsv, :num-values [0 0], :app
EVENT_TYPE_PLAYER_UPDATE, :lat 0.11433330178260803, :player {:y
-2733.36376953125, :description X: 70.35 Y: -2733.36 Z: 94.3298 O:
1.47023, :o 1.470227837562561, :name Tranchis, :level 80, :z
94.32979583740234, :x 70.35002136230469, :map 1, :guid 3}, :area s000ds,
:interval 1414478700, :timestamp 1414478938, :event-type
EVENT_TYPE_PLAYER_UPDATE, :lng 0.11713701486587524}
{:geohash s000dsv613r8, :sector s000dsv, :num-values [0 0], :app
EVENT_TYPE_PLAYER_UPDATE, :lat 0.11433330178260803, :player {:y
-2733.36376953125, :description X: 70.35 Y: -2733.36 Z: 92.7634 O:
1.47023, :o 1.470227837562561, :name Tranchis, :level 80, :z
92.76342010498047, :x 70.35002136230469, :map 1, :guid 3}, :area s000ds,
:interval 1414478700, :timestamp 1414478938, :event-type
EVENT_TYPE_PLAYER_UPDATE, :lng 0.11713701486587524}
{:test "ok", :actions ()}

:o 3.6387131214141846, :name Tranchis, :level 80, :z 92.6298599243164,
:x 61.665367126464844, :map 1, :guid 3}, :area s000ds, :interval
1414479600, :timestamp 1414479611, :event-type EVENT_TYPE_PLAYER_UPDATE,
:lng 0.11712833493947983}
{:geohash s000dsv616b8, :sector s000dsv, :geometry {:lat
0.1143413633108139, :lng 0.11712756007909775}, :num-values [0 0], :app
EVENT_TYPE_PLAYER_UPDATE, :lat 0.1143413633108139, :player {:y
-2725.302490234375, :description X: 60.8916 Y: -2725.3 Z: 91.7523 O:
3.63871, :o 3.6387131214141846, :name Tranchis, :level 80, :z
91.75232696533203, :x 60.89158248901367, :map 1, :guid 3}, :area s000ds,
:interval 1414479600, :timestamp 1414479611, :event-type
EVENT_TYPE_PLAYER_UPDATE, :lng 0.11712756007909775}


db.events.find({geometry:{$near:[0.1143413633108139,0.11712756007909775],
$maxDistance: 0.0001}, "creature.name" : "Horde Guard"}).pretty()

0,1143009141087532  0,11713197082281113
0,11433330178260803  0,11713701486587524

0,00003277804143


0,00000109260138 u/yard

