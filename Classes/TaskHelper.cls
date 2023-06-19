public with sharing class TaskHelper {
    public static void checkOpenCase(List<task> taskList) {
        Set<Id> caseIds = new Set<Id>();
        Set<Id> whatIdsList = new Set<Id>();

        for (Task task : taskList) {
            caseIds.add(task.WhatId);
        }

        Map<Id, Case> caseMap = new Map<Id, Case>([
            SELECT Id, 
                (SELECT Id FROM Tasks WHERE isClosed = false LIMIT 1) 
            FROM Case 
            WHERE Id IN :caseIds
        ]);

        for (Task task : taskList) {
            Case newCase = caseMap.get(task.WhatId);
            if (newCase != null && newCase.Tasks.size() > 0) {
                task.addError(label.taskError);
            }
            if (whatIdsList.contains(task.WhatId)) {
                task.addError(label.taskError);
            } else {
                whatIdsList.add(task.WhatId);
            }
        }
    }
}