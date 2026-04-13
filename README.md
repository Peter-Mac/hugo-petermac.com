# hugo-petermac.com
The petermac.com website as supported by the Hugo static site generator

## How it works
I've got a content folder with a combination of stand alone pages (about, services, contact etc), then a 'posts' folder under which I have year/month folders where post material goes.

Through lessons learned, I'd removed any UI based operations into a self-named themes folder. This contains the code I used from the original theme with modifications to suit my specific needs. 

It is possible to use a theme and keep it intact while replicating files in your own layouts folder but I found myself continually editing the wrong version of the file and wondering why things weren't working. In the end I decided to keep the themes/petermac-theme folder and focus on getting that part working to process outputs according to my needs.

## Installing Hugo

On macOS, `brew install hugo` is the path I use. For anything else, see Hugo's [official install docs](https://gohugo.io/installation/) — they cover Linux package managers, Windows, and direct binary downloads.

Keep Hugo current. After an upgrade, run `./build.sh` to catch any deprecation breakage early — Hugo surfaces removed template fields and renamed config keys as hard build errors, so they're easy to spot rather than silently wrong.

## Search (Pagefind)

For search I use [Pagefind](https://pagefind.app) as a lightweight content indexer. `build.sh` invokes it via npx after the Hugo build:

```bash
npx pagefind@latest --site ./public --output-subdir pagefind
```

No local Pagefind install needed — npx downloads it to the per-user npm cache on first run.

## Deployment

I deploy to Cloudflare Pages. Originally I set the project up through the CF web portal, then moved to the CLI (`wrangler`) once I realised it fit my workflow better.

### First-time Cloudflare deploy setup

Prerequisites for running `./cloudflare_deploy.sh`:

1. **Node.js** available locally (I use `nvm` — `nvm install lts/jod` then `nvm use lts/jod`).
2. **Wrangler**: pulled in by `npm install` in the project (it's a devDep).
3. **Cloudflare auth**: `npx wrangler login` — one-time per machine.
4. The Cloudflare Pages project `hugo-petermac-com` must already exist.

## Publish Process
1. Create a new folder under the Content/Year/Month structure.  I will usually name the folder with the name of the post I'm about to create. 

2. Create an index.md file within the folder.

3. Add any images to the folder and refer to them in the content with the necessary markdown.

4. When happy with the article wording run the build script (build.sh).

5. To view in local preview (before committing anything) run `./start.sh`. This executes a local preview server on port 3000 (bound to your LAN IP so you can view it from other devices on the network).

6. Once happy with the content, commit everything to git with a simple git commit and git push.

7. Finally run the cloudflare_deploy script (which uses the wrangler command) to push the latest updates to the live site.

```bash
./cloudflare_deploy.sh
```

