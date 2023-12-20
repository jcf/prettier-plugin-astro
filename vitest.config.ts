/// <reference types="vitest" />
import { defineConfig } from 'vitest/config';

export default defineConfig({
	test: {
		include: ['test/tests/**/*.{test,spec}.?(c|m)[jt]s?(x)'],
		threads: false,
	},
});
