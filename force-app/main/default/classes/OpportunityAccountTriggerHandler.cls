/**
 * Creates and links one account for each newly inserted opportunity.
 */
public without sharing class OpportunityAccountTriggerHandler {
    /**
     * Creates accounts in system mode as part of opportunity trigger automation.
     * @param opportunities Opportunities being inserted by the trigger.
     */
    public static void createAccounts(List<Opportunity> opportunities) {
        List<Account> accountsToCreate = new List<Account>();

        for (Opportunity opportunityRecord : opportunities) {
            accountsToCreate.add(new Account(Name = opportunityRecord.Name));
        }

        // Trigger automation creates the related account in system mode.
        Database.insert(accountsToCreate, AccessLevel.SYSTEM_MODE);

        for (Integer i = 0; i < opportunities.size(); i++) {
            opportunities[i].AccountId = accountsToCreate[i].Id;
        }
    }
}
