<?php

namespace App\Http\Controllers\Admin;

use App\Models\Vendor;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\VendorRequest;
use App\Repositories\Contracts\VendorRepositoryInterface;
use App\Repositories\Contracts\CategoryRepositoryInterface;

class VendorController extends Controller
{
    protected $vendorRepository;
    protected $categoryRepository;

    public function __construct(
        VendorRepositoryInterface $vendorRepository,
        CategoryRepositoryInterface $categoryRepository
    
    )
    {
        $this->vendorRepository = $vendorRepository;
        $this->categoryRepository = $categoryRepository;
    
    }
    // Display a listing of vendors
    public function index(Request $request)
    {
        $query = Vendor::query();
        
        // Search filter
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function($q) use ($search) {
                $q->where('business_name', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%")
                  ->orWhere('phone', 'like', "%{$search}%");
            });
        }
        
        // Status filter
        if ($request->filled('status')) {
            switch ($request->status) {
                case 'approved':
                    $query->where('is_approved', true)->where('blocked', false);
                    break;
                case 'pending':
                    $query->where('is_approved', false)->where('blocked', false);
                    break;
                case 'blocked':
                    $query->where('blocked', true);
                    break;
            }
        }
        
        // Sorting
        if ($request->filled('sort')) {
            switch ($request->sort) {
                case 'newest':
                    $query->orderBy('created_at', 'desc');
                    break;
                case 'oldest':
                    $query->orderBy('created_at', 'asc');
                    break;
                case 'name_asc':
                    $query->orderBy('business_name', 'asc');
                    break;
                case 'name_desc':
                    $query->orderBy('business_name', 'desc');
                    break;
                default:
                    $query->orderBy('created_at', 'desc');
            }
        } else {
            $query->orderBy('created_at', 'desc');
        }
        
        $vendors = $query->get();
        
        return view('admin.vendors.index', compact('vendors'));
    }

    // Show the form for creating a new vendor
    public function create()
    {        $categories = $this->categoryRepository->all();

        return view('admin.vendors.create',compact('categories'));
    }
    public function store(VendorRequest $request)
    {
        $data = $request->validated();
    

    
        // Create the vendor
        $vendor = $this->vendorRepository->create($data);
    
        // Attach categories
        if ($request->has('categories')) {
            $vendor->categories()->sync($request->categories);
        } 
    
        return redirect()->route('admin.vendors.index')->with('success', 'Vendor created successfully.');
    }
   // Display the specified vendor
public function show($id)
    {
        $vendor = $this->vendorRepository->find($id);
        return view('admin.vendors.show', compact('vendor'));
    }

    // Show the form for editing the specified vendor
    public function edit($id)
    {
        $vendor = $this->vendorRepository->find($id);
        $categories = $this->categoryRepository->all();

        return view('admin.vendors.edit', compact('vendor','categories'));
    }

    // Update the specified vendor in the database
    public function update(VendorRequest $request, $id)
    {
        $this->vendorRepository->update($id, $request->validated());
        return redirect()->route('admin.vendors.index')->with('success', __('Vendor updated successfully.'));
    }

    // Remove the specified vendor from the database
    public function destroy($id)
    {
        $this->vendorRepository->delete($id);
        return redirect()->route('admin.vendors.index')->with('success', __('Vendor deleted successfully.'));
    }

    // Approve a vendor
    public function approve($id)
    {
        $this->vendorRepository->approve($id);
        return redirect()->route('admin.vendors.index')->with('success', __('Vendor approved successfully.'));
    }

    // Block a vendor
    public function block($id)
    {
        $this->vendorRepository->block($id);
        return redirect()->route('admin.vendors.index')->with('success', __('Vendor blocked successfully.'));
    }

    // Unblock a vendor
    public function unblock($id)
    {
        $this->vendorRepository->unblock($id);
        return redirect()->route('admin.vendors.index')->with('success', __('Vendor unblocked successfully.'));
    }
}