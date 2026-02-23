import OpenAI from "openai";

const openai = new OpenAI({
    baseURL: "http://localhost:1234/v1",
    apiKey: "lm-studio"
});

const ct = new Date();
const completion = await openai.chat.completions.create({
    model: "qwen/qwen3-4b-2507",
    messages: [
        { role: "user", content: "conte uma piada de sogra" },
        { role: "assistant", content: "você deve responder em poucas palavras e em portugues brasileiro" }
    ],
});

console.log(completion.choices[0].message);
const rt = Math.round((new Date() - ct) / 1000);

console.log(`Response time: ${rt}s`);