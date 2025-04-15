#[starknet::contract]


mod todo_contract {
    use starknet::ContractAddress;
    use starknet::get_caller_address;

    struct Task {
        description: felt252,
        completed: bool,
    }

    #[storage]
    struct Storage {
        tasks: LegacyMap<u128, Task>,
        task_count: u128,
    }

    #[external(v0) ]
    fn add_task(ref self: ContractState, description: felt252) {
        let id = self.task_count.read();
        self.tasks.write(id, Task { description, completed: false });
        self.task_count.write(id + 1);
    }

    #[external(v0)]
    fn complete_task(ref self: ContractState, task_id: u128) {
        let mut task = self.tasks.read(task_id);
        task.completed = true;
        self.tasks.write(task_id, task);
    }

    #[external(v0) ]
    fn delete_task(ref self: ContractState, task_id: u128) {
        self.tasks.remove(task_id);
    }

    // #[view]
    fn get_task(ref self: ContractState, task_id: u128) -> Task {
        self.tasks.read(task_id)
    }
}
