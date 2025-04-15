#[cfg(test)]
mod tests {
    use super::*;
    use snforge_std::{start_prank, Cheatcodes, SafeDispatcher};

    #[test]
    fn test_add_and_get_task() {
        let dispatcher = SafeDispatcher::deploy(todo_contract::Contract, ());
        dispatcher.add_task("Learn Cairo".into());

        let task = dispatcher.get_task(0);
        assert(task.description == "Learn Cairo");
        assert(task.completed == false);
    }
}
