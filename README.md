# Developer Box on Azure

## Getting Started

These steps are needed to be done only once.

- Clone this repository:

```bash
git clone https://github.com/surajssd/azure-developer-box
```

- Create `config.env` and update config in it:

```bash
cp config.env.example config.env
```

- Set up the machine:

```bash
make setup
```

- You can auto-shutdown the VM by running the following command:

```bash
make set-autoshutdown
```

## Enter in to the machine

If the machine is not running then start it:

```bash
make start
```

SSH into the machine:

```bash
make ssh
```

## Save Resources

```bash
make stop
```

## Permanent Cleanup

```bash
make destroy
```
