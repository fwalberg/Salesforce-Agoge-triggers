@isTest
public with sharing class TaskHelperTest {

    // Testa o cenário de inserção de nova tarefa sem existir outra em aberto para o mesmo Caso
    // Inserindo uma tarefa individualmente.
    // Cenário de Sucesso.
    @isTest
    public static void checkClosedTask() {
        Boolean hasError = false;
        String errorMessage = '';
        
        try {
            TestFactorySObject sobjectFactory = TestFactorySObject.getInstance();
            
            Case newCase1 = (Case)sobjectFactory.createSObject(new Case());
            insert newCase1;

            Task newTask1 = (Task)sobjectFactory.createSObject(new Task(
                WhatId = newCase1.Id
            ));
            insert newTask1;

            hasError = false;
        } 
        catch (DmlException e) {
            errorMessage = e.getMessage();
            hasError = true;
        }

        System.assertEquals(false, hasError);
    }

    // Testa o cenário de inserção de nova tarefa sem existir outra em aberto para o mesmo Caso,
    // Inserindo uma lista de tarefas.
    // Cernário de Sucesso.
    @isTest
    public static void checkClosedTaskList() {
        Boolean hasError = false;
        String errorMessage = '';
        
        try {
            TestFactorySObject sobjectFactory = TestFactorySObject.getInstance();
            
            Case newCase1 = (Case)sobjectFactory.createSObject(new Case());
            insert newCase1;

            Case newCase2 = (Case)sobjectFactory.createSObject(new Case());
            insert newCase2;

            Task newTask1 = (Task)sobjectFactory.createSObject(new Task(
                WhatId = newCase1.Id
            ));

            Task newTask2 = (Task)sobjectFactory.createSObject(new Task(
                WhatId = newCase2.Id
            ));

            List<Task> taskList = new List<Task>();
            taskList.add(newTask1);
            taskList.add(newTask2);

            insert taskList;

            hasError = false;
        } 
        catch (DmlException e) {
            errorMessage = e.getMessage();
            hasError = true;
        }

        System.assertEquals(false, hasError);
    }

    // Testa o cenário de já existir uma tarefa em aberto para o mesmo caso,
    // Inserindo tarefas individualmente.
    // Cenário de erro.
    @isTest
    public static void checkOpenTask() {
        Boolean hasError = false;
        String errorMessage = '';

        try {

            TestFactorySObject sobjectFactory = TestFactorySObject.getInstance();
            
            Case newCase1 = (Case)sobjectFactory.createSObject(new Case());
            insert newCase1;

            Task newTask1 = (Task)sobjectFactory.createSObject(new Task(
                WhatId = newCase1.Id
            ));
            insert newTask1;

            Task newTask2 = (Task)sobjectFactory.createSObject(new Task(
                WhatId = newCase1.Id
            ));
            insert newTask2;

            hasError = false;
        } 
        catch (Exception e) {
           hasError = true;
           errorMessage = e.getMessage();
        }
        
        System.assertEquals(true, hasError);
    }

    // Testa o cenário de já existir uma tarefa em aberto para o mesmo caso,
    // Inserindo uma lista tarefas.
    // Cenário de erro.
    @isTest
    public static void checkOpenTaskList() {
        Boolean hasError = false;
        String errorMessage = '';
        
        try {
            TestFactorySObject sobjectFactory = TestFactorySObject.getInstance();
            
            Case newCase1 = (Case)sobjectFactory.createSObject(new Case());
            insert newCase1;

            Task newTask1 = (Task)sobjectFactory.createSObject(new Task(
                WhatId = newCase1.Id
            ));

            Task newTask2 = (Task)sobjectFactory.createSObject(new Task(
                WhatId = newCase1.Id
            ));

            List<Task> taskList = new List<Task>();
            taskList.add(newTask1);
            taskList.add(newTask2);

            insert taskList;

            hasError = false;
        } 
        catch (DmlException e) {
            hasError = true;
            errorMessage = e.getMessage();
        }

        System.assertEquals(true, hasError);
    }
}