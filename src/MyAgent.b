agent MyAgent memberof BaseGroup, SystemGroup {
    // This is a simple agent that does nothing.
    // It is used to test the Brahms environment.
    // It is also used to test the Brahms compiler.
    // It is used to test the Brahms runtime.

    attributes:
        // The agent has no attributes.
        public string name;

    initial_beliefs:
        (current.name = "MyAgent");

    workframes:

        workframe wf_PrintName {
            variables:
                forone(string) nm;
            when ((current.name = nm))
            do {
                println("==================================");
                println("This is a test model for testing");
                println("the Brahms environment.");
                println("The output should be the agent's");
                println("belief about its name:");
                println("");
                printBelief(current, name, attribute);
                println("==================================");
            }
        }
} // MyAgent