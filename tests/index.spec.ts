import { flags } from "../src/renderer";

test("Example", async () => {
  expect(flags.message).toBe("Hello World");
});
