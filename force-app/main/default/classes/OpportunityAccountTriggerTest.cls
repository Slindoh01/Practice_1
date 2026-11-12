@IsTest
private class OpportunityAccountTriggerTest {
    @IsTest
    static void createsAndLinksAnAccountForEachOpportunity() {
        List<Opportunity> opportunities = new List<Opportunity>{
            new Opportunity(Name = 'First Opportunity', StageName = 'Prospecting', CloseDate = Date.today().addDays(30)),
            new Opportunity(Name = 'Second Opportunity', StageName = 'Prospecting', CloseDate = Date.today().addDays(30))
        };

        Test.startTest();
        insert opportunities;
        Test.stopTest();

        List<Opportunity> insertedOpportunities = [
            SELECT Name, AccountId, Account.Name
            FROM Opportunity
            WHERE Id IN :opportunities
        ];

        System.assertEquals(2, insertedOpportunities.size(), 'Both opportunities should be inserted.');
        for (Opportunity opportunityRecord : insertedOpportunities) {
            System.assertNotEquals(null, opportunityRecord.AccountId, 'Each opportunity should link to an account.');
            System.assertEquals(opportunityRecord.Name, opportunityRecord.Account.Name, 'Account name should match the opportunity name.');
        }
    }
}
