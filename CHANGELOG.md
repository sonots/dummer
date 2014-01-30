### 0.3.2 (2014/01/31)

Fixes:

  * Fix `any` which did not include max

### 0.3.1 (2014/01/31)

Enhancement:

  * Support posting data to Fluentd process directly

### 0.3.0 (2014/01/25)

Big Changes:

  * Rename application name from `dummy_log_generator` to `dummer`. `dummy_log_generator` was too long.

### 0.2.3 (2014/01/22)

Fixes:

  * Fix datetime type format (thanks xcezx)

### 0.2.2 (2014/01/15)

Enhancement:

  * Add CLI options to `dummer` command

### 0.2.1

Change:

  * Change the default behavior to use the default `message` rather than `field`.

### 0.2.0

Enhancement:

  * Add `message` option to write only a specific message
  * Add `input` option to write messges by reading lines of an input file in roration
  * Add `dummer_simple` command
  * Add `dummer_yes` command

### 0.1.0

Enhancement:

  * Support to output into a file (`output` option)
  * No dependency on active_support
  * Speed-up (Proc-based evaluation)
  * Support parallel (`workers` option)

### 0.0.4

Enhancement:

  * Add `format` option to `string`, `integer`, `float` data type

### 0.0.3

Enhancement:

  * Add `value` option to specify fixed value

### 0.0.2

Enhancement:

  * Add `countup: true` suppert

### 0.0.1

First version
