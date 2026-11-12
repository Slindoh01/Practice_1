trigger OpportunityAccountTrigger on Opportunity (before insert) {
    OpportunityAccountTriggerHandler.createAccounts(Trigger.new);
}
