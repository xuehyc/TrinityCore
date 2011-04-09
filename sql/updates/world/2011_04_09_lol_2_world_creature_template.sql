-- tempfix quest 12984
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~512, `WDBVerified`=1 WHERE `entry`=29368;
