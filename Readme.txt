MVC crud operation
-Structure (Unit of work pattern)
-Coding standard
-Error handling

Steps :-
1)Run the script and create the database
2)Change in web.config and app.config for connection(Put your own that you have ceated by script).



SELECT  sb.SubscriberId,
		sb.Id As SubsciberBusinessId,
		sb.Name As SubsciberBusinessName,
		sbu.Id As SubsciberBusinessUnitId,
		sbu.Name As SubsciberBusinessUnitName,
		(CASE WHEN IsNull(sbum.SubscriberLoactionId, 0) <> 0 THEN 1 ELSE 0 END) As IsChecked 
		FROM SubscriberBusinessUnits sbu LEFT JOIN SubscriberBusinessUnitMapping sbum ON 
		sbu.Id = sbum.SubscriberLoactionId AND sbum.SubscriberUserId = 1
		LEFT JOIN SubscriberBusiness sb ON sb.Id = sbu.SubsciberBusinessId AND sb.SubscriberId = 1
