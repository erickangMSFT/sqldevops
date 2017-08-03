SELECT planForceDetails.query_id, reason, score,
       JSON_VALUE(details, '$.implementationDetails.script') script,
       planForceDetails.[new plan_id], planForceDetails.[recommended plan_id]
FROM sys.dm_db_tuning_recommendations
     CROSS APPLY OPENJSON (Details, '$.planForceDetails')
                 WITH ( [query_id] int '$.queryId',
                        [new plan_id] int '$.regressedPlanId',
                        [recommended plan_id] int '$.forcedPlanId'
                 ) as planForceDetails;