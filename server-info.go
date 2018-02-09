package main

import (
    "fmt"
    // "encoding/json"
    "github.com/shirou/gopsutil/host"
    "github.com/shirou/gopsutil/cpu"
    "github.com/shirou/gopsutil/mem"
    "github.com/shirou/gopsutil/load"
    "github.com/shirou/gopsutil/disk"
)

func main() {

   host, _ := host.Info()
   cpuinfo, _ := cpu.Info()
   swapmem, _ := mem.SwapMemory()
   virtmem, _ := mem.VirtualMemory()
   loadinfo, _ := load.Avg()
   partinfo, _ := disk.Partitions(true)

   // format json
   // json_output, _ := json.MarshalIndent(usageinfo, "", "   ")
   // fmt.Printf("%s", json_output)

   //    Output
   fmt.Println()
   fmt.Println("===== Host Info =====")
   fmt.Println("Hostname : " + host.Hostname)
   fmt.Println("OS       : " + host.OS)
   fmt.Println("Kernel   : " + host.KernelVersion)
   fmt.Println()
   fmt.Println("===== CPU Info =====")
   for _, info := range cpuinfo{
       fmt.Println("CPU      : " + info.ModelName)
       fmt.Printf("MHZ      : %.0f\n", info.Mhz)
       fmt.Printf("Cores    : %x\n", info.Cores)
   }
   fmt.Println()
   fmt.Println("===== Mem Info =====")
   fmt.Printf("Swap     : %.2f\n", swapmem.UsedPercent)
   fmt.Printf("Virt     : %.2f\n", virtmem.UsedPercent)
   fmt.Println()
   fmt.Println("===== Load Info =====")
   fmt.Printf("1min     : %.2f\n", loadinfo.Load1)
   fmt.Printf("5min     : %.2f\n", loadinfo.Load5)
   fmt.Printf("15min    : %.2f\n", loadinfo.Load15)
   fmt.Println()
   fmt.Println("===== Disk Info =====")
   for _, part := range partinfo{
       fmt.Println("Mount    : " + part.Mountpoint)
       usageinfo, _ := disk.Usage(part.Mountpoint)
       fmt.Printf("Used     : %.2f\n", usageinfo.UsedPercent)
       if len(partinfo) > 1 {
           fmt.Println("---------------------")
       }
   }
   fmt.Println()
}
