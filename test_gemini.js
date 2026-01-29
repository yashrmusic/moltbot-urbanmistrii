const { GoogleGenerativeAI } = require("@google/generative-ai");
const fs = require('fs');
const genAI = new GoogleGenerativeAI("AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM");

async function testModel(modelName) {
    try {
        const model = genAI.getGenerativeModel({ model: modelName });
        const result = await model.generateContent("Hi");
        const response = await result.response;
        return `[PASS] ${modelName}: ${response.text().substring(0, 30)}\n`;
    } catch (e) {
        return `[FAIL] ${modelName}: ${e.message}\n`;
    }
}

async function run() {
    const models = ["gemini-1.5-flash-8b"];
    let output = await testModel(models[0]);
    fs.writeFileSync('test_results_8b.txt', output);
    console.log(output);
}
run();
