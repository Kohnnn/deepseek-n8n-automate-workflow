# Self-hosted AI starter kit

**Self-hosted AI Starter Kit** is an open, docker compose template that
quickly bootstraps a fully featured Local AI and Low Code development
environment including Open WebUI for an interface to chat with your N8N agents.

This is Cole's version with a couple of improvements and the addition of Open WebUI!
Also, the local RAG AI Agent workflow from the video will be automatically in your
n8n instance if you use this setup instead of the base one provided by n8n!

Download my N8N + OpenWebUI integration [directly on the Open WebUI site.](https://openwebui.com/f/coleam/n8n_pipe/) (more instructions below)

![n8n.io - Screenshot](https://raw.githubusercontent.com/n8n-io/self-hosted-ai-starter-kit/main/assets/n8n-demo.gif)

Heavily inspired by [https://github.com/n8n-io](https://github.com/n8n-io) and [https://github.com/coleam00](https://github.com/coleam00), it combines the self-hosted n8n
platform with a curated list of compatible AI products and components to
quickly get started with building self-hosted AI workflows.
This repo fork is to focus on the core apps, remove Ollama dependencies in Docker for more models scaling, and adding easy accessability to local files.

> [!TIP]
> [Read the announcement](https://blog.n8n.io/self-hosted-ai/)

### What’s included

✅ [**Self-hosted n8n**](https://n8n.io/) - Low-code platform with over 400
integrations and advanced AI components

✅ [**Open WebUI**](https://openwebui.com/) - ChatGPT-like interface to
privately interact with your local models and N8N agents

✅ [**Qdrant**](https://qdrant.tech/) - Open-source, high performance vector
store with an comprehensive API

✅ [**PostgreSQL**](https://www.postgresql.org/) -  Workhorse of the Data
Engineering world, handles large amounts of data safely.

### What will you need to add

✅ [**Ollama**](https://ollama.com/) - Cross-platform LLM platform to install
and run the latest local LLMs

### What you can build

⭐️ AI Agents which can schedule appointments

⭐️ Summarise company PDFs without leaking data

⭐️ Smarter slack bots for company comms and IT-ops

⭐️ Analyse financial documents privately and for little cost

## Installation

### Download the open-source LLMs tool [right here](https://ollama.com/):

After installation, run the app and visit [http://localhost:11434]() on you browser, you should get: 

```
Ollama is running
```

No you can download and use any GGUF/HF/EXL2 LLMs directly in terminal or through any supported platform.
Go to [Ollama Models](https://ollama.com/search), choose any models you want to run, I suggest [llama3.2:3b](https://ollama.com/library/llama3.2:3b) for first use, the run this code:

```
ollama run llama3.2:3b
```

These are only the mainstreams LLMs models, you can access to more advance one on websites likes: [Models - Hugging Face](https://huggingface.co/models) and even customize/fine tuning your own models.

##### Optional: Change the models installation folder to different drive.

Since Ollama store models in your C:\ drive, it is difficult to scale up for more sophisticated models.
You can change it by follow this guide: [How to Deploy and Experiment with Ollama Models on Your Local Machine (Windows) | by Avighan Majumder | Medium](https://medium.com/@dpn.majumder/how-to-deploy-and-experiment-with-ollama-models-on-your-local-machine-windows-34c967a7ab0e)

### Install Dockers and the local AI kit

Download and install these dependencies:

* [Git - Downloads](https://git-scm.com/downloads) - to manage source code
* [Windows | Docker Docs](https://docs.docker.com/desktop/setup/install/windows-install/) - to develope and host the apps

### For Nvidia GPU users

```
git clone https://github.com/Kohnnn/local-ai-starter-kit.git
cd local-ai-starter-kit
docker compose --profile gpu-nvidia up
```

> [!NOTE]
> If you have not used your Nvidia GPU with Docker before, please follow the
> [Ollama Docker instructions](https://github.com/ollama/ollama/blob/main/docs/docker.md).

### For Mac / Apple Silicon users

If you're using a Mac with an M1 or newer processor, you can't expose your GPU
to the Docker instance, unfortunately. There are two options in this case:

1. Run the starter kit fully on CPU, like in the section "For everyone else"
   below
2. Run Ollama on your Mac for faster inference, and connect to that from the
   n8n instance

If you want to run Ollama on your mac, check the
[Ollama homepage](https://ollama.com/)
for installation instructions, and run the starter kit as follows:

```
git clone https://github.com/Kohnnn/local-ai-starter-kit.git
cd local-ai-starter-kit
docker compose up
```

After you followed the quick start set-up below, change the Ollama credentials
by using `http://host.docker.internal:11434/` as the host.

### For everyone else

```
git clone https://github.com/Kohnnn/local-ai-starter-kit.git
cd local-ai-starter-kit
docker compose --profile cpu up
```

## ⚡️ Quick start and usage

The main component of the self-hosted AI starter kit is a docker compose file
pre-configured with network and disk so there isn’t much else you need to
install. After completing the installation steps above, follow the steps below
to get started.

1. Open [http://localhost:5678/](http://localhost:5678/) in your browser to set up n8n. You’ll only
   have to do this once. You are NOT creating an account with n8n in the setup here,
   it is only a local account for your instance!
2. Open the included workflow:
   [http://localhost:5678/workflow/vTN9y2dLXqTiDfPT](http://localhost:5678/workflow/vTN9y2dLXqTiDfPT)
3. Create credentials for every service:

   Ollama URL: http://localhost:11434 ##Your local Ollama

   Postgres: use DB, username, and password from .env. Host is postgres

   Qdrant URL: http://qdrant:6333 (API key can be whatever since this is running locally)

   Google Drive: Follow [this guide from n8n](https://docs.n8n.io/integrations/builtin/credentials/google/).
   Don't use localhost for the redirect URI, just use another domain you have, it will still work!
   Alternatively, you can set up [local file triggers](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.localfiletrigger/).
4. Select **Test workflow** to start running the workflow.
5. If this is the first time you’re running the workflow, you may need to wait
   until Ollama finishes downloading Llama3.1. You can inspect the docker
   console logs to check on the progress.
6. Make sure to toggle the workflow as active and copy the "Production" webhook URL!
7. Open [http://localhost:3000/](http://localhost:3000/) in your browser to set up Open WebUI.
   You’ll only have to do this once. You are NOT creating an account with Open WebUI in the
   setup here, it is only a local account for your instance!
8. Go to Workspace -> Functions -> Add Function -> Give name + description then paste in
   the code from `n8n_pipe.py`

   The function is also [published here on Open WebUI&#39;s site](https://openwebui.com/f/coleam/n8n_pipe/).
9. Click on the gear icon and set the n8n_url to the production URL for the webhook
   you copied in a previous step.
10. Toggle the function on and now it will be available in your model dropdown in the top left!

**To open n8n at any time, visit [http://localhost:5678/](http://localhost:5678/) in your browser.
To open Open WebUI at any time, visit [http://localhost:3000/](http://localhost:3000/).**

With your n8n instance, you’ll have access to over 400 integrations and a
suite of basic and advanced AI nodes such as
[AI Agent](https://docs.n8n.io/integrations/builtin/cluster-nodes/root-nodes/n8n-nodes-langchain.agent/),
[Text classifier](https://docs.n8n.io/integrations/builtin/cluster-nodes/root-nodes/n8n-nodes-langchain.text-classifier/),
and [Information Extractor](https://docs.n8n.io/integrations/builtin/cluster-nodes/root-nodes/n8n-nodes-langchain.information-extractor/)
nodes. To keep everything local, just remember to use the Ollama node for your
language model and Qdrant as your vector store.

> [!NOTE]
> This starter kit is designed to help you get started with self-hosted AI
> workflows. While it’s not fully optimized for production environments, it
> combines robust components that work well together for proof-of-concept
> projects. You can customize it to meet your specific needs

## Upgrading

### For Nvidia GPU users

```
docker compose --profile gpu-nvidia pull
docker compose create && docker compose --profile gpu-nvidia up
```

### For Mac / Apple Silicon users

```
docker compose pull
docker compose create && docker compose up
```

### For everyone else

```
docker compose --profile cpu pull
docker compose create && docker compose --profile cpu up
```

## 👓 Recommended reading

n8n is full of useful content for getting started quickly with its AI concepts
and nodes. If you run into an issue, go to [support](#support).

- [AI agents for developers: from theory to practice with n8n](https://blog.n8n.io/ai-agents/)
- [Tutorial: Build an AI workflow in n8n](https://docs.n8n.io/advanced-ai/intro-tutorial/)
- [Langchain Concepts in n8n](https://docs.n8n.io/advanced-ai/langchain/langchain-n8n/)
- [Demonstration of key differences between agents and chains](https://docs.n8n.io/advanced-ai/examples/agent-chain-comparison/)
- [What are vector databases?](https://docs.n8n.io/advanced-ai/examples/understand-vector-databases/)

## 🎥 Video walkthrough

- [Installing and using Local AI for n8n](https://www.youtube.com/watch?v=xz_X2N-hPg0)

## 🛍️ More AI templates

For more AI workflow ideas, visit the [**official n8n AI template
gallery**](https://n8n.io/workflows/?categories=AI). From each workflow,
select the **Use workflow** button to automatically import the workflow into
your local n8n instance.

### Learn AI key concepts

- [AI Agent Chat](https://n8n.io/workflows/1954-ai-agent-chat/)
- [AI chat with any data source (using the n8n workflow too)](https://n8n.io/workflows/2026-ai-chat-with-any-data-source-using-the-n8n-workflow-tool/)
- [Chat with OpenAI Assistant (by adding a memory)](https://n8n.io/workflows/2098-chat-with-openai-assistant-by-adding-a-memory/)
- [Use an open-source LLM (via HuggingFace)](https://n8n.io/workflows/1980-use-an-open-source-llm-via-huggingface/)
- [Chat with PDF docs using AI (quoting sources)](https://n8n.io/workflows/2165-chat-with-pdf-docs-using-ai-quoting-sources/)
- [AI agent that can scrape webpages](https://n8n.io/workflows/2006-ai-agent-that-can-scrape-webpages/)

### Local AI templates

- [Tax Code Assistant](https://n8n.io/workflows/2341-build-a-tax-code-assistant-with-qdrant-mistralai-and-openai/)
- [Breakdown Documents into Study Notes with MistralAI and Qdrant](https://n8n.io/workflows/2339-breakdown-documents-into-study-notes-using-templating-mistralai-and-qdrant/)
- [Financial Documents Assistant using Qdrant and](https://n8n.io/workflows/2335-build-a-financial-documents-assistant-using-qdrant-and-mistralai/) [Mistral.ai](http://mistral.ai/)
- [Recipe Recommendations with Qdrant and Mistral](https://n8n.io/workflows/2333-recipe-recommendations-with-qdrant-and-mistral/)

## Tips & tricks

### Accessing local files

The self-hosted AI starter kit will create a shared folder (by default,
located in the same directory) which is mounted to the n8n container and
allows n8n to access files on disk. This folder within the n8n container is
located at `/data/shared` -- this is the path you’ll need to use in nodes that
interact with the local filesystem.

**Nodes that interact with the local filesystem**

- [Read/Write Files from Disk](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.filesreadwrite/)
- [Local File Trigger](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.localfiletrigger/)
- [Execute Command](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.executecommand/)

**Using free AI Agent API**

* [Gemini Experimental 1206 (free) - API, Providers, Stats | OpenRouter](https://openrouter.ai/google/gemini-exp-1206:free)
* [Llama 3.2 90B Vision Instruct (free) - API, Providers, Stats | OpenRouter](https://openrouter.ai/meta-llama/llama-3.2-90b-vision-instruct:free)
* [Llama 3.1 405B Instruct (free) - API, Providers, Stats | OpenRouter](https://openrouter.ai/meta-llama/llama-3.1-405b-instruct:free)
* [Mistral 7B Instruct (free) - API, Providers, Stats | OpenRouter](https://openrouter.ai/mistralai/mistral-7b-instruct:free)

## 📜 License

This project is licensed under the Apache License 2.0 - see the
[LICENSE](LICENSE) file for details.

## ⚡️Special thanks

Special thanks to [https://github.com/n8n-io](https://github.com/n8n-io) and [https://github.com/coleam00](https://github.com/coleam00) for the guide, you can refer to their documentation for more advance AI application tutorial.

## 💬 Support

Join the conversation in the [n8n Forum](https://community.n8n.io/), where you
can:

- **Share Your Work**: Show off what you’ve built with n8n and inspire others
  in the community.
- **Ask Questions**: Whether you’re just getting started or you’re a seasoned
  pro, the community and our team are ready to support with any challenges.
- **Propose Ideas**: Have an idea for a feature or improvement? Let us know!
  We’re always eager to hear what you’d like to see next.
